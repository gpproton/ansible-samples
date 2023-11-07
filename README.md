# Ansible Samples

### Step 1

```bash
git clone https://github.com/gpproton/easy-ansible.git && \
cd easy-ansible && \
chmod +x ./play
```

### Step 2

update inventory.ini or Vagratfile with appropriate info

### Step 3

Ensure either virtual box or quem (lib-virt) are available

### Step 4

```bash
./play setup
```

### Step 5

```bash
./play run playbooks/ping.yaml
## OR
./play playbooks/ping.yaml
```

## Various how examples for ansible usage

- [x] User & permission setup
  - [x] Generate SSH key
  - [x] Generate ansible password from file
  - [x] Create new ansible user
  - [x] Copy SSH public key to servers
  - [x] Disable root password login
- [ ] System setup
  - [ ] host file setup
  - [ ] Setup base packages
  - [ ] Update all packages repo
  - [ ] Upgrade packages
  - [ ] Set hostnames
  - [ ] Set desired timezone
  - [ ] Set sysctl limits
  - [ ] Set system ulimits
- [x] Glusterfs setup
  - [x] Install gluster packages
  - [x] Gluster firewall changes
  - [x] Cluster setup
  - [x] Volume and bricks setup
  - [x] fstab mount setup
- [ ] Docker setup
  - [ ] install docker
  - [ ] install docker compose
  - [ ] Add custom docker config
  - [ ] Add ansible user to docker group
  - [ ] initialize docker swarm
  - [ ] Add masters to swarm
  - [ ] Add workers to swarm
  - [ ] Add roles to cluster leave, re-initialization
- [ ] Sample servies
  - [ ] nignx highly available service
