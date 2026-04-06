Return-Path: <linux-can+bounces-7340-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0G7lEkYe1GmJrQcAu9opvQ
	(envelope-from <linux-can+bounces-7340-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 06 Apr 2026 22:57:42 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E473A759C
	for <lists+linux-can@lfdr.de>; Mon, 06 Apr 2026 22:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 241013011C9B
	for <lists+linux-can@lfdr.de>; Mon,  6 Apr 2026 20:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12AC3081A2;
	Mon,  6 Apr 2026 20:57:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DAE1EF09B
	for <linux-can@vger.kernel.org>; Mon,  6 Apr 2026 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775509058; cv=none; b=ciABQEcODmv8F4GMroKin4E9uwMZviqGg4KwfmhrLLYhu93gTyf7zR4Mz78zdHzakv6JEpTLVBHAsf8LnE6ZgUYH3yh2lLzMq3bVT5cjRX01VPcBUPRMJi8wwGHabaGnpAHQgQXg/cmaBMKTS0KLYltUOqQGIfF/IST+ca8ekyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775509058; c=relaxed/simple;
	bh=FtsIl5QLObpJJOr79nVtYG8IMGGQMtKFTzb1IPtRcgw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F6stqKyQdsbcHz7Q40iFlHUYFnemAOZwTBul52WYJMNhhm1f1M0NtKF/H8Vr6EW54IMsM8ISG6sod4HIbvjrz7KbZGPw5a7GXOECN7JHMFaxQBpXgsr/bWDxc3p+C0sRre56Gt+y+bJmyi/OS4u/n5EJknYfgDklDCWPt/wyAnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7dbc38e0e64so4194389a34.0
        for <linux-can@vger.kernel.org>; Mon, 06 Apr 2026 13:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775509056; x=1776113856;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n5Ibwoiivy+FWnfB/EMTkKmS+iZgWA3oBT3SHFxz4rQ=;
        b=Yeqw+XNB6BayM1YLAPyKmESe4qH32+q5nuQr0A/VbCrdjty8OA3G74TeK9zAK15gJq
         Lp234Sn8pfHRINmlnFge0tfEbOalJ3CBQjLK/P85yZ06H7mD2gDOSptlGmGnCVTyQr3M
         YYScKW/GMroOJIRtUpmNUtSxZWAm8baKZO4Ik1xLg1KpbWp0mEWXtN02ErMatfQbu1wC
         +HFnGAQoCTUwLdngH8Lu4S5cjBq9jHXRpgaIqPt7xEPjWgn4rvonQf93rik2wPd8tR+a
         X9vREDQtMWj4zJWUTXe+/Ok/ge42tcn26b87B2ZElB6QAUZcDu5fmmdqnPL3B4nbBQ+M
         MElA==
X-Gm-Message-State: AOJu0Yw5itwOjR52Z09V1gSw7qVxM8XsDpPZiZFbaq3uIU4VjYlGrkrX
	umcf3gYnZCY1Td87+QCXTXEXi524PRmpbqKS24GvdPDTvS6Pm9u8QDhfrdCUkef7Z4JOPZhrvc0
	ZmAox3X6KJAPTSFtO6Czs1PM+9o74ExKqr+N7+4rHcX+gcd3erdIrJsDQVoDhTw==
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2d42:b0:680:17e0:4443 with SMTP id
 006d021491bc7-68220a48ef3mr7225063eaf.63.1775509056444; Mon, 06 Apr 2026
 13:57:36 -0700 (PDT)
Date: Mon, 06 Apr 2026 13:57:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69d41e40.a70a0220.a26f2.0040.GAE@google.com>
Subject: [syzbot] [can?] KCSAN: data-race in _copy_from_iter / bcm_can_tx
From: syzbot <syzbot+71cffbc1f77596292d08@syzkaller.appspotmail.com>
To: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=3a78dd265deac3a9];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7340-lists,linux-can=lfdr.de,71cffbc1f77596292d08];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,storage.googleapis.com:url,goo.gl:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: E1E473A759C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    7ca6d1cfec80 Merge tag 'powerpc-7.0-4' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b359f6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a78dd265deac3a9
dashboard link: https://syzkaller.appspot.com/bug?extid=71cffbc1f77596292d08
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/22943b1048bd/disk-7ca6d1cf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/36afcbebeb04/vmlinux-7ca6d1cf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3088e4f4695f/bzImage-7ca6d1cf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+71cffbc1f77596292d08@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in _copy_from_iter / bcm_can_tx

read to 0xffff88810cf825f8 of 72 bytes by interrupt on cpu 1:
 skb_put_data include/linux/skbuff.h:2800 [inline]
 bcm_can_tx+0x1b3/0x4c0 net/can/bcm.c:327
 bcm_tx_timeout_handler+0xe5/0x290 net/can/bcm.c:478
 __run_hrtimer kernel/time/hrtimer.c:1785 [inline]
 __hrtimer_run_queues+0x218/0x4f0 kernel/time/hrtimer.c:1849
 hrtimer_run_softirq+0xe0/0x2c0 kernel/time/hrtimer.c:1866
 handle_softirqs+0xb9/0x2a0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x39/0xc0 kernel/softirq.c:723
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0x37/0x80 arch/x86/kernel/apic/apic.c:1056
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697

write to 0xffff88810cf825f8 of 72 bytes by task 5344 on cpu 0:
 instrument_copy_from_user_before include/linux/instrumented.h:147 [inline]
 copy_from_user_iter lib/iov_iter.c:66 [inline]
 iterate_iovec include/linux/iov_iter.h:52 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
 iterate_and_advance include/linux/iov_iter.h:330 [inline]
 __copy_from_iter lib/iov_iter.c:261 [inline]
 _copy_from_iter+0x258/0xea0 lib/iov_iter.c:272
 copy_from_iter include/linux/uio.h:228 [inline]
 copy_from_iter_full include/linux/uio.h:245 [inline]
 memcpy_from_msg include/linux/skbuff.h:4273 [inline]
 bcm_tx_setup+0xae5/0xdd0 net/can/bcm.c:966
 bcm_sendmsg+0x357/0x4a0 net/can/bcm.c:1434
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x563/0x5b0 net/socket.c:2592
 ___sys_sendmsg+0x195/0x1e0 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0xd4/0x160 net/socket.c:2681
 x64_sys_call+0x194c/0x3020 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 5344 Comm: syz.3.483 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
==================================================================


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

