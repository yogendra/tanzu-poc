# TKC + TKG + TO - PoC

Documentation located in [doc/]

Putitng together a scripts and config for running PoC.

## Jumpbox Setup

Initialize jumpbox

```
sudo ./jumpbox/init.sh
```

## Cluster Buildout

| Cluster   | New/Existing | Falvor | INFRA (VPC) | Description                                |
| --------- | ------------ | ------ | ----------- | ------------------------------------------ |
| cluster-1 | NEW          | TKG    | EXISITING   | New TKG Cluster in Client AWS account      |
| cluster-2 | NEW          | EKS    | NEW         | New EKS Cluster in Vendor AWS account      |
| cluster-3 | NEW          | EKS    | EXISTING    | New EKS Cluster in Client AWS account      |
| cluster-4 | EKS          | EKS    | EXISTING    | Existing EKS Cluster in Client AWS account |
| cluster-5 | NEW          | TKG    | NEW         | New TKG Cluster in Vendor AWS account      |

### Extentions Installation Status

|    Extensions | cluster-1 | cluster-2 | cluster-3 | cluster-4 | cluster-5 |
| ------------: | :-------: | :-------: | :-------: | :-------: | :-------: |
|           tmc |           |           |           |           |     X     |
|     wavefront |           |           |           |           |     x     |
|           psp |           |           |           |           |    x\*    |
|           dex |    N/A    |    N/A    |    N/A    |    N/A    |    N/A    |
|       gangway |    N/A    |    N/A    |    N/A    |    N/A    |    N/A    |
| metric-server |           |           |           |           |     x     |
|     fluentbit |           |           |           |           |           |
|  cert-manager |           |           |           |           |     x     |
|       contour |           |           |           |           |     x     |
|      sonobuoy |           |           |           |           |    N/A    |
|        velero |           |           |           |           |           |

## Extensions: TMC

- Namespace: vmware-system-tmc
- Service Account: vmware--system

## PSP

Create PSP for extention's service account

```
kubectl create rolebinding privileged-role-binding \
    --clusterrole=vmware-system-tmc-psp-privileged \
    --user=system:serviceaccount:<ns>:<sa>
```

Cert Manager

```
kubectl create rolebinding privileged-role-binding \
    --clusterrole=vmware-system-tmc-psp-privileged \
    --user=system:serviceaccount:<ns>:<sa>
```

## Harbor

Robot Account

- Username: robot\$image-pull-k8s
  Token:
  ```
  eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE1OTcwMzcxOTAsImlzcyI6ImhhcmJvci10b2tlbi1kZWZhdWx0SXNzdWVyIiwiaWQiOjEsInBpZCI6MiwiYWNjZXNzIjpbeyJSZXNvdXJjZSI6Ii9wcm9qZWN0LzIvcmVwb3NpdG9yeSIsIkFjdGlvbiI6InB1bGwiLCJFZmZlY3QiOiIifSx7IlJlc291cmNlIjoiL3Byb2plY3QvMi9oZWxtLWNoYXJ0IiwiQWN0aW9uIjoicmVhZCIsIkVmZmVjdCI6IiJ9XX0.TXzqUdiPvJ_HojTSMbeZ6_voPVatYV0ftNhbelhw8RkQehUypo8OItnb1PIQi0PxzJWc5eHRjVYOY4IiykhHhWmfHOFEAlOKRwHSQAbW17WD8yJr6w_OXoJCOHzWvBWXQsTCnViTCydhwhc736LGQpRq1BdTIKxtjjaHfjQO-6yLTVNroIEUgZCQIhgLTd1Si-hrrVKT4JYum0ABoRRTRFSqRinZzHG1ca4e1HdE4yb9ygM7IOZHeNiPgY2cfhN0mlmaWTOm5lC5WzB3VuuJ8-D4PXaa-8rZ_1GTfFiEBlZ-TbF6J5keBjqyrpNaSu6W7tZMKYnkg8WWCb7jtJ72r7wHgfXQmY2XTUBK77owFCvTc2rSTDbMI7RsnFO_ugko9SwFrr81CLUcYDWjSMtd35YEAtRyfYH15e0ISs3KjSrq8BYhwr1ZIL1RKZBnMxacHPnBooh1Ep6badqvdcyFb5m27Yy0Uz457n2SxY8br_DPn3v5Cz7EJCLy7PBNnW8K6zLqkW1nvrIaaXXPHiel4V_L_Ir64OPPLTkFhVpRU4bt8_3LcuuEWZLgdTim1E-eqR15bONNN-oKLbd5bNlLfYc2ZJ3wP_4MX6pbmCN7aszQztdhwulUqO24UdRr65Gz1SQYl_0LE-EI3ujmoH4mroIY14DODy2Ou1QHBK4p0B8
  ```

* Username: robot\$push-account
  Token
  ```
  eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE1OTcwMzgzODksImlzcyI6ImhhcmJvci10b2tlbi1kZWZhdWx0SXNzdWVyIiwiaWQiOjQsInBpZCI6MiwiYWNjZXNzIjpbeyJSZXNvdXJjZSI6Ii9wcm9qZWN0LzIvcmVwb3NpdG9yeSIsIkFjdGlvbiI6InB1c2giLCJFZmZlY3QiOiIifSx7IlJlc291cmNlIjoiL3Byb2plY3QvMi9oZWxtLWNoYXJ0LXZlcnNpb24iLCJBY3Rpb24iOiJjcmVhdGUiLCJFZmZlY3QiOiIifV19.K3l4HtW4RyfQ5WCTQ5QdRZJP7m1rpPIsqrBuzA9Hu2afDKZTdyZAi1bBzvU5QvlUlX5U362k6LDHt1onTzLbE9aWGQ3Iw6nALNlRB5IXf6EvkFum0PlSi35oudFKQklDWfsGk3CN9WPT97969H6qyk_CRUVu2X4s-rwnitsa_JocQlFBCEW2hx2O5gURfuVHx9ydOmsYStmZhPGsTQod6JRc1SThkzYf7M39_IeO4W-nqT_ytQ3Kjqxsd8DJDJP5AxgQdgz9EZKiIhtKrwQzzlHxUYbAdrWqVdsvCfRmfQFi_RwcPN57qHuOGOeFj9umvljHJXqWbhzvqnqPWto6JU8B8279sce_JERhaMjgZC47q0ZEFuncMx0nzrbnY38MvoETEe360Q6e77GqUwf-kWjwtnoRmJ7j6qqlQwnbp7NmpEZ9c-Lr5a52Ktw0tl2wWX_VykxEpTI_C9DFVYrZvDwwzSg_XZJETp9FE2w7GjrpPVPaAVapY7O6C3vhEFLdoeeKaNENov0cJMPd6BvJXuuoqcFD0EwrnSWDOsD_fXkKaspYxEiSrwck6TKsZO7OTck8po8Axw7r5LLvkxjs_sCcxuaLJn0sGMvce1zf2hRyA8SXIR4tj7FDvi2JlISVQzo2ax8EPZwjffGV_3OqW5Q419sZBPMtz7MVvRazzC0
  ```

### Connections

- Access TKG Cluster VMs on Custiome Account

  ```
  (Mac) -> (Jumpbox) -> (Bastion) -> (TKG CLuster VMS)
  ```

* Jumpbox is running on VMware QWS Account
* Bastion host has IP Filter and Private Key based authentication
* Bation to Cluster VMs will take a bit .. may be 2 min to connect

Bation Host:
54.179.189.118
10.95.190.178

On Workstation

```sh
ssh ubuntu@ec2-18-140-237-16.ap-southeast-1.compute.amazonaws.com
```

On Jumbox

```sh
ssh yogi@54.179.189.118
```

On Bastion

```sh
ssh -i poc-clusters.pem ec2-user@<cluster-host>
```
