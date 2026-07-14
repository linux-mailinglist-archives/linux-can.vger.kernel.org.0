Return-Path: <linux-can+bounces-8370-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yBfCMHj8VWq4xQAAu9opvQ
	(envelope-from <linux-can+bounces-8370-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 11:08:08 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D37752AE9
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 11:08:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8370-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8370-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A14D301F9E6
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 09:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575543F2109;
	Tue, 14 Jul 2026 09:07:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7443C05C
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 09:07:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020057; cv=none; b=OkG+1UJa1NMpvjq68AxwhvZwbxuyRkjtq4xfFc21BLjTNTUX2CJKvP2Y2RR/QECrXKa7XMWehOPfs1ZatBImQ6P8Ddqu5yOAbSpE6YF+n9+sHZd/jFm4Kwb1wazKV8jBGYuNVSuUvU+p0xjWC+Pkt9pkKnXO2eVtKMYNgQnNodw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020057; c=relaxed/simple;
	bh=IxyVm7IcUo+sYsGc1/ouWUkFvePLEebZ32KySG+8Gpc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hPBVNVfFUJaMjDO5NLYhYZ5ZJgD66792LeqAjHNbjHJE70zyKScc/bGKPy8tZWv/49JUOeMm0Fa1MsTxFrQrQvrjz4QYdWUk05gapjTs6GxZ/0JlEbWeSokbiyMjA2VyVfjUbh3pfxk3FYiQ8MRRowZkL3IAc9A9EaEf7s+cuh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-4a43d32fa9fso1648225b6e.2
        for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 02:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784020054; x=1784624854;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CLaw79NsoRicP9YAsZkAlIoUkA6HQkt0ISaCfQaznWU=;
        b=D54ZvMzqX8Ctf91YAnMn23DotkFBqrjzn4EeaPYeGJY+TTTCa/vv1K/Vqbb0F/FRyB
         ttZLdSghcvYMN8MVgify6W9s8300PF3Zy1V9BTdZavRrFeM9wL8opinikOXOeRliHLDj
         FDfdLRrYnrQjV7v4jRtR+Ea+6g7yylmgUAVeD6B/OH5pc18jGZaS/wB3odFIen0Bi6f+
         K726ag4/nqy+Pv3qYlRN6oJace6mXo31HHq3uYsZUyBz0HlJB1J9y9bY/yyQpy+diPmr
         eU4UA08uAr6OavcEPRcGsZ5FlXTSnllhjYE9LfABWtYcLLKpJVH4dyNSgvupzzhYp4WZ
         LyOg==
X-Forwarded-Encrypted: i=1; AFNElJ/qo1/lKt/7aJqEp90/jPXf2dlFAx5bMXkptoJd/I7TVn0qWlsLOpbzKMhOR+48DDTdXIS27R0C8pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YygM/ntSYALUawvVwoVlJZT4XfPWBcGcJ+3XyCzjK3wPrTo1q8J
	lwyRff3nOU0JqlVslyX7TQg6Nacs2mZUhwS7rY3VIFId0QacKl9pxHdN3d8PXzxSLlj6qnZK7cP
	X9qCbPFBTGprLODg8qUpdwMajA6ehdC1g65BDTS9XxGrOS8s2laMkZ9XMtEM=
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2386:b0:495:fa73:2e21 with SMTP id
 5614622812f47-4a42b04ed3cmr9179923b6e.33.1784020054266; Tue, 14 Jul 2026
 02:07:34 -0700 (PDT)
Date: Tue, 14 Jul 2026 02:07:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a55fc56.c90005c7.37d349.001c.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in rtnl_net_dev_lock
From: syzbot <syzbot+de610eeef174bd59a8a3@syzkaller.appspotmail.com>
To: dario.binacchi@amarulasolutions.com, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mailhol@kernel.org, mkl@pengutronix.de, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=c00ea6b66be5f95];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dario.binacchi@amarulasolutions.com,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:netdev@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,linux-can@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8370-lists,linux-can=lfdr.de,de610eeef174bd59a8a3];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,googlegroups.com:email,vger.kernel.org:from_smtp,syzkaller.appspot.com:url,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goo.gl:url];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[7];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14D37752AE9

Hello,

syzbot found the following issue on:

HEAD commit:    bee763d5f341 Add linux-next specific files for 20260710
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17d360b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c00ea6b66be5f95
dashboard link: https://syzkaller.appspot.com/bug?extid=de610eeef174bd59a8a3
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/34c8f306351e/disk-bee763d5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d6fb1414f52c/vmlinux-bee763d5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2e7f8585b4c7/bzImage-bee763d5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+de610eeef174bd59a8a3@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
kworker/u8:47/12528 is trying to acquire lock:
ffff8880517dd070 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2852 [inline]
ffff8880517dd070 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
ffff8880517dd070 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: call_netdevice_unregister_notifiers net/core/dev.c:1917 [inline]
ffff8880517dd070 (&dev_instance_lock_key#3){+.+.}-{4:4}, at: call_netdevice_unregister_net_notifiers+0x1e0/0x4c0 net/core/dev.c:1953

but task is already holding lock:
ffffffff8f7c1e78 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
ffffffff8f7c1e78 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_dev_lock+0x257/0x2f0 net/core/dev.c:2167

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (rtnl_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       _mutex_lock_killable+0x63/0x1d0 kernel/locking/rtmutex_api.c:599
       rtnl_net_lock_killable include/linux/rtnetlink.h:145 [inline]
       register_netdev+0x18/0x60 net/core/dev.c:11565
       slcan_open+0x35f/0x440 drivers/net/can/slcan/slcan-core.c:857
       tty_ldisc_open+0xa1/0x100 drivers/tty/tty_ldisc.c:432
       tty_set_ldisc+0x365/0x540 drivers/tty/tty_ldisc.c:563
       tty_ioctl+0xc36/0xde0 drivers/tty/tty_io.c:2728
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xff/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&tty->ldisc_sem){++++}-{0:0}:
       __ldsem_down_read_nested+0xb2/0x790 drivers/tty/tty_ldsem.c:300
       tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
       tty_poll+0x6b/0x170 drivers/tty/tty_io.c:2195
       vfs_poll include/linux/poll.h:82 [inline]
       ep_item_poll fs/eventpoll.c:1328 [inline]
       ep_insert+0x11ee/0x1830 fs/eventpoll.c:1928
       do_epoll_ctl_file+0x8d5/0xf00 fs/eventpoll.c:2677
       do_epoll_ctl fs/eventpoll.c:2724 [inline]
       __do_sys_epoll_ctl fs/eventpoll.c:2741 [inline]
       __se_sys_epoll_ctl+0x162/0x230 fs/eventpoll.c:2732
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&ep->mtx){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       get_epoll_tfile_raw_ptr+0x86/0x1a0 fs/eventpoll.c:2909
       kcmp_epoll_target+0x14f/0x1f0 kernel/kcmp.c:117
       __do_sys_kcmp kernel/kcmp.c:207 [inline]
       __se_sys_kcmp+0x668/0x8f0 kernel/kcmp.c:135
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&sig->exec_update_lock){++++}-{4:4}:
       down_read_killable+0xa4/0x220 kernel/locking/rwsem.c:1599
       mm_access+0x4d/0x2c0 kernel/fork.c:1409
       proc_map_files_lookup+0x3d3/0x6b0 fs/proc/base.c:2340
       lookup_open fs/namei.c:4476 [inline]
       open_last_lookups fs/namei.c:4602 [inline]
       path_openat+0x112d/0x3850 fs/namei.c:4854
       do_file_open+0x23e/0x4a0 fs/namei.c:4886
       do_sys_openat2+0x115/0x200 fs/open.c:1368
       do_sys_open fs/open.c:1374 [inline]
       __do_sys_openat fs/open.c:1390 [inline]
       __se_sys_openat fs/open.c:1385 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1385
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&sb->s_type->i_mutex_key#11){++++}-{4:4}:
       down_read+0x97/0x200 kernel/locking/rwsem.c:1574
       inode_lock_shared include/linux/fs.h:1039 [inline]
       lookup_slow+0x46/0x70 fs/namei.c:1935
       walk_component fs/namei.c:2282 [inline]
       lookup_last fs/namei.c:2789 [inline]
       path_lookupat+0x3f5/0x8c0 fs/namei.c:2813
       filename_lookup+0x265/0x5d0 fs/namei.c:2842
       kern_path+0x3d/0x150 fs/namei.c:3036
       bpf_prog_get_type_path+0xa3/0x270 kernel/bpf/inode.c:642
       __bpf_mt_check_path net/netfilter/xt_bpf.c:60 [inline]
       bpf_mt_check_v1+0x156/0x360 net/netfilter/xt_bpf.c:84
       xt_checkentry_match net/netfilter/x_tables.c:543 [inline]
       xt_check_match+0x602/0xce0 net/netfilter/x_tables.c:576
       __nft_match_init+0x66b/0x8c0 net/netfilter/nft_compat.c:546
       nft_match_large_init+0xc0/0x150 net/netfilter/nft_compat.c:568
       nf_tables_newexpr net/netfilter/nf_tables_api.c:3633 [inline]
       nf_tables_newrule+0x179e/0x28a0 net/netfilter/nf_tables_api.c:4451
       nfnetlink_rcv_batch net/netfilter/nfnetlink.c:524 [inline]
       nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:647 [inline]
       nfnetlink_rcv+0x1291/0x28d0 net/netfilter/nfnetlink.c:665
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x7f5/0x990 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
       sock_sendmsg_nosec+0x13a/0x180 net/socket.c:810
       __sock_sendmsg net/socket.c:825 [inline]
       ____sys_sendmsg+0x565/0x870 net/socket.c:2727
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2781
       __sys_sendmsg net/socket.c:2813 [inline]
       __do_sys_sendmsg net/socket.c:2818 [inline]
       __se_sys_sendmsg net/socket.c:2816 [inline]
       __x64_sys_sendmsg+0x1b7/0x290 net/socket.c:2816
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&nft_net->commit_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       nf_tables_netdev_event+0xad/0x160 net/netfilter/nft_chain_filter.c:416
       call_netdevice_notifier net/core/dev.c:1893 [inline]
       call_netdevice_register_notifiers net/core/dev.c:1901 [inline]
       call_netdevice_register_net_notifiers+0x133/0x750 net/core/dev.c:1934
       register_netdevice_notifier+0x96/0x160 net/core/dev.c:1990
       nft_chain_filter_netdev_init net/netfilter/nft_chain_filter.c:442 [inline]
       nft_chain_filter_init+0x1d/0x80 net/netfilter/nft_chain_filter.c:468
       nf_tables_module_init+0x25/0x100 net/netfilter/nf_tables_api.c:12216
       do_one_initcall+0x250/0x870 init/main.c:1357
       do_initcall_level+0x10a/0x1a0 init/main.c:1419
       do_initcalls+0x59/0xa0 init/main.c:1435
       kernel_init_freeable+0x29d/0x3e0 init/main.c:1670
       kernel_init+0x22/0x1d0 init/main.c:1560
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (&dev_instance_lock_key#3){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3181 [inline]
       check_prevs_add kernel/locking/lockdep.c:3300 [inline]
       validate_chain kernel/locking/lockdep.c:3924 [inline]
       __lock_acquire+0x15ff/0x2e40 kernel/locking/lockdep.c:5254
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5906
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       netdev_lock include/linux/netdevice.h:2852 [inline]
       netdev_lock_ops include/net/netdev_lock.h:42 [inline]
       call_netdevice_unregister_notifiers net/core/dev.c:1917 [inline]
       call_netdevice_unregister_net_notifiers+0x1e0/0x4c0 net/core/dev.c:1953
       __unregister_netdevice_notifier_net net/core/dev.c:2084 [inline]
       unregister_netdevice_notifier_dev_net+0x159/0x1a0 net/core/dev.c:2214
       nsim_destroy+0x105/0x800 drivers/net/netdevsim/netdev.c:1185
       __nsim_dev_port_del+0x14e/0x200 drivers/net/netdevsim/dev.c:1547
       nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1561 [inline]
       nsim_dev_reload_destroy+0x288/0x490 drivers/net/netdevsim/dev.c:1785
       nsim_dev_reload_down+0x8a/0xc0 drivers/net/netdevsim/dev.c:1038
       devlink_reload+0x1c5/0x890 net/devlink/dev.c:462
       devlink_pernet_pre_exit+0x1ff/0x420 net/devlink/core.c:578
       ops_pre_exit_list net/core/net_namespace.c:161 [inline]
       ops_undo_list+0x17d/0x8d0 net/core/net_namespace.c:234
       cleanup_net+0x575/0x810 net/core/net_namespace.c:702
       process_one_work+0xaaf/0x1480 kernel/workqueue.c:3379
       process_scheduled_works kernel/workqueue.c:3462 [inline]
       worker_thread+0xb05/0x10d0 kernel/workqueue.c:3543
       kthread+0x388/0x470 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

Chain exists of:
  &dev_instance_lock_key#3 --> &tty->ldisc_sem --> rtnl_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(rtnl_mutex);
                               lock(&tty->ldisc_sem);
                               lock(rtnl_mutex);
  lock(&dev_instance_lock_key#3);

 *** DEADLOCK ***

locks held by kworker/u8:47/12528: 6, last CPU#1:
 #0: ffff88801bee0938 ((wq_completion)netns){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffff88801bee0938 ((wq_completion)netns){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffff88801bee0938 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x7fd/0x1480 kernel/workqueue.c:3344
 #1: ffffc9000473fc60 (net_cleanup_work){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #1: ffffc9000473fc60 (net_cleanup_work){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #1: ffffc9000473fc60 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x7fd/0x1480 kernel/workqueue.c:3344
 #2: ffffffff8f7b2b60 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xf5/0x810 net/core/net_namespace.c:673
 #3: ffff888037bdd160 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1104 [inline]
 #3: ffff888037bdd160 (&dev->mutex){....}-{4:4}, at: devl_dev_lock net/devlink/devl_internal.h:124 [inline]
 #3: ffff888037bdd160 (&dev->mutex){....}-{4:4}, at: devlink_pernet_pre_exit+0x129/0x420 net/devlink/core.c:575
 #4: ffff888038d1e310 (&devlink->lock_key#10){+.+.}-{4:4}, at: devl_lock net/devlink/core.c:308 [inline]
 #4: ffff888038d1e310 (&devlink->lock_key#10){+.+.}-{4:4}, at: devl_dev_lock net/devlink/devl_internal.h:125 [inline]
 #4: ffff888038d1e310 (&devlink->lock_key#10){+.+.}-{4:4}, at: devlink_pernet_pre_exit+0x142/0x420 net/devlink/core.c:575
 #5: ffffffff8f7c1e78 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #5: ffffffff8f7c1e78 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_dev_lock+0x257/0x2f0 net/core/dev.c:2167

stack backtrace:
CPU: 1 UID: 0 PID: 12528 Comm: kworker/u8:47 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2059
 check_noncircular+0x12f/0x150 kernel/locking/lockdep.c:2191
 check_prev_add kernel/locking/lockdep.c:3181 [inline]
 check_prevs_add kernel/locking/lockdep.c:3300 [inline]
 validate_chain kernel/locking/lockdep.c:3924 [inline]
 __lock_acquire+0x15ff/0x2e40 kernel/locking/lockdep.c:5254
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5906
 __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
 mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
 netdev_lock include/linux/netdevice.h:2852 [inline]
 netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 call_netdevice_unregister_notifiers net/core/dev.c:1917 [inline]
 call_netdevice_unregister_net_notifiers+0x1e0/0x4c0 net/core/dev.c:1953
 __unregister_netdevice_notifier_net net/core/dev.c:2084 [inline]
 unregister_netdevice_notifier_dev_net+0x159/0x1a0 net/core/dev.c:2214
 nsim_destroy+0x105/0x800 drivers/net/netdevsim/netdev.c:1185
 __nsim_dev_port_del+0x14e/0x200 drivers/net/netdevsim/dev.c:1547
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1561 [inline]
 nsim_dev_reload_destroy+0x288/0x490 drivers/net/netdevsim/dev.c:1785
 nsim_dev_reload_down+0x8a/0xc0 drivers/net/netdevsim/dev.c:1038
 devlink_reload+0x1c5/0x890 net/devlink/dev.c:462
 devlink_pernet_pre_exit+0x1ff/0x420 net/devlink/core.c:578
 ops_pre_exit_list net/core/net_namespace.c:161 [inline]
 ops_undo_list+0x17d/0x8d0 net/core/net_namespace.c:234
 cleanup_net+0x575/0x810 net/core/net_namespace.c:702
 process_one_work+0xaaf/0x1480 kernel/workqueue.c:3379
 process_scheduled_works kernel/workqueue.c:3462 [inline]
 worker_thread+0xb05/0x10d0 kernel/workqueue.c:3543
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
netdevsim netdevsim4 netdevsim3 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim4 netdevsim2 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim4 netdevsim1 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim4 netdevsim0 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
bridge_slave_1: left allmulticast mode
bridge_slave_1: left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge_slave_0: left allmulticast mode
bridge_slave_0: left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): Released all slaves
hsr_slave_0: left promiscuous mode
hsr_slave_1: left promiscuous mode
batman_adv: batadv0: Interface deactivated: batadv_slave_0
batman_adv: batadv0: Removing interface: batadv_slave_0
batman_adv: batadv0: Interface deactivated: batadv_slave_1
batman_adv: batadv0: Removing interface: batadv_slave_1
veth1_macvtap: left promiscuous mode
veth0_macvtap: left promiscuous mode
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
netdevsim netdevsim6 netdevsim3 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim6 netdevsim2 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim6 netdevsim1 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim6 netdevsim0 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

