Return-Path: <linux-can+bounces-6579-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLCPOBZnlGkpDgIAu9opvQ
	(envelope-from <linux-can+bounces-6579-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 17 Feb 2026 14:03:18 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8438B14C4CB
	for <lists+linux-can@lfdr.de>; Tue, 17 Feb 2026 14:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2332B3004907
	for <lists+linux-can@lfdr.de>; Tue, 17 Feb 2026 13:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F191F1513;
	Tue, 17 Feb 2026 13:02:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F369627472
	for <linux-can@vger.kernel.org>; Tue, 17 Feb 2026 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771333351; cv=none; b=MxH8hGl9/YkdLPkQ+LJX7izVl0wtutP97biNFVbEe/mPPn+/9y1qgLrc/radtJmypMuWSy5urkU9BBGs6XphT2tM/iZo5breIJStBnw6X4hDN47TyAR9rpBktZmvB6SwgqMfAgb3gRR+1rnqYgOyLnXg/K0yToOigvpwfjnxdOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771333351; c=relaxed/simple;
	bh=WPLsCNhn1thEVcrjq5zrjx51VConz1BGX1lMEFRyp98=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WeOlZx7a3ouSREsk6Zh+LSkgRpD1C7ooNqDhTgC/JbjOE7jrN0a7hrYZGv8U8OOOoT/JkgQxNJfbLG5G37DhUjKYYFa4muyNBCZ5SKoJAcjd+bjM6Lpa+/ZNYmzhYtUPpmhOPZRlL6+xKi2ZmwZEiQ7wxPQ8pOXj36P2e4WrZ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-67992287096so19944056eaf.2
        for <linux-can@vger.kernel.org>; Tue, 17 Feb 2026 05:02:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771333349; x=1771938149;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J0jM1VBHOq9P06C8jciHsqOrZxRSemPvh+Y7cAs4mFs=;
        b=sZtcoDU4VddaNPUX4yKPgcZJUdPAR3mGBc+SydELP2N+N2sIa1IRVorvc2fw4V+oSH
         kVHrJO76Jnh0/S/9jAzZDyV/xDsft6X1hVdx43L5egwqRCDgl7WVwXVyNSpLzXr3iqrq
         BHsaE3+taf9sizUkdVXJMfqHY5UBB/zYjU1MC1E4rpqkfII/osjmNr5BHrjsih9peIh8
         vrnzXwv0O7Y4fU1J6FBEuzXpBhyBntC7bREAC7N8UgUXejixgedq/2kYN5GEDUxdhLz5
         LfoWeVclrAVrV5jbzHzbNrAESc6f6t+8gxzK7piRQ377X2fJyMnb4RGY9XCxqyziOId2
         +08Q==
X-Gm-Message-State: AOJu0Yxr/qFV2rIinxljjGIZ6mf9BNhBMYb3hz7wRr45U1n4Ms4KouQG
	WfAyIjsSWZJLRQsdJTkxmjfSW9/ExOrAYtorFnWMUSBiLZ4HtpqbHGwtfqevQSpIUA4qaAkA3i6
	ygQFj1qD6OwPdCbkdhukv5k3mmYcZr0w8vLsvQD0x2WVLN6OPwa24QFvSr0o=
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c83:b0:664:7c2b:c79f with SMTP id
 006d021491bc7-6785c22b085mr5636380eaf.73.1771333348986; Tue, 17 Feb 2026
 05:02:28 -0800 (PST)
Date: Tue, 17 Feb 2026 05:02:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699466e4.a70a0220.2c38d7.00ff.GAE@google.com>
Subject: [syzbot] [can?] INFO: trying to register non-static key in bcm_can_tx
From: syzbot <syzbot+5b11eccc403dd1cea9f8@syzkaller.appspotmail.com>
To: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f71c66df48515cc1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6579-lists,linux-can=lfdr.de,5b11eccc403dd1cea9f8];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,appspotmail.com:email,goo.gl:url,syzkaller.appspot.com:url,googlegroups.com:email]
X-Rspamd-Queue-Id: 8438B14C4CB
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    cee73b1e840c Merge tag 'riscv-for-linus-7.0-mw1' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=172d2c02580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f71c66df48515cc1
dashboard link: https://syzkaller.appspot.com/bug?extid=5b11eccc403dd1cea9f8
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c8415a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a2fa52580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9e927e1d94c1/disk-cee73b1e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2203b2372c8f/vmlinux-cee73b1e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab3f368371b6/bzImage-cee73b1e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b11eccc403dd1cea9f8@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 5983 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 assign_lock_key kernel/locking/lockdep.c:984 [inline]
 register_lock_class+0x549/0x560 kernel/locking/lockdep.c:1299
 __lock_acquire+0x3cb/0x2630 kernel/locking/lockdep.c:5112
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x17c/0x330 kernel/locking/lockdep.c:5825
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:150 [inline]
 _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:347 [inline]
 bcm_can_tx.part.0+0x79/0x890 net/can/bcm.c:305
 bcm_can_tx net/can/bcm.c:301 [inline]
 bcm_rx_handler+0x6fa/0x880 net/can/bcm.c:731
 deliver net/can/af_can.c:575 [inline]
 can_rcv_filter+0x2a4/0x900 net/can/af_can.c:609
 can_receive+0x2cb/0x500 net/can/af_can.c:674
 can_rcv+0x29e/0x300 net/can/af_can.c:699
 __netif_receive_skb_one_core+0x1b2/0x1e0 net/core/dev.c:6149
 __netif_receive_skb+0x1f/0x120 net/core/dev.c:6262
 process_backlog+0x37a/0x1580 net/core/dev.c:6614
 __napi_poll.constprop.0+0xaf/0x450 net/core/dev.c:7678
 napi_poll net/core/dev.c:7741 [inline]
 net_rx_action+0xa40/0xf20 net/core/dev.c:7893
 handle_softirqs+0x1ea/0x910 kernel/softirq.c:622
 do_softirq kernel/softirq.c:523 [inline]
 do_softirq+0xac/0xe0 kernel/softirq.c:510
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xf8/0x120 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:924 [inline]
 __dev_queue_xmit+0x7f1/0x46f0 net/core/dev.c:4856
 dev_queue_xmit include/linux/netdevice.h:3384 [inline]
 can_send+0x5d7/0xbd0 net/can/af_can.c:279
 raw_sendmsg+0xdf9/0x1480 net/can/raw.c:1000
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa54/0xc30 net/socket.c:2592
 ___sys_sendmsg+0x190/0x1e0 net/socket.c:2646
 __sys_sendmsg+0x170/0x220 net/socket.c:2678
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fab0c99bf79
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff12c0b798 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fab0cc15fa0 RCX: 00007fab0c99bf79
RDX: 0000000020044850 RSI: 0000200000000240 RDI: 0000000000000003
RBP: 00007fab0ca327e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fab0cc15fac R14: 00007fab0cc15fa0 R15: 00007fab0cc15fa0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

