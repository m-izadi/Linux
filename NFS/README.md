# Install
    # sudo apt install nfs-kernel-server

# Config

    vim /etc/exports
        /nfs/db     192.168.0.0/24(rw,sync,no_subtree_check,no_root_squash)


    - no_root_squash
        - بعضی از سرویس ها نیاز به دسترسی سی اچ اون دارند ک اگر این دسترسی نباشه سرویس به مشکل میخوره
# Enable Service
    exportfs -a
    systemctl restart nfs-kernel-server.services

# Set Permission
    chown -R nobody. /nfs/db/
    chmod -R 777 /nfs/db/