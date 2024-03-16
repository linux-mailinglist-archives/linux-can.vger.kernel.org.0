Return-Path: <linux-can+bounces-398-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE5087DABE
	for <lists+linux-can@lfdr.de>; Sat, 16 Mar 2024 17:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1741F218CD
	for <lists+linux-can@lfdr.de>; Sat, 16 Mar 2024 16:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F8F1BC41;
	Sat, 16 Mar 2024 16:19:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F271B974
	for <linux-can@vger.kernel.org>; Sat, 16 Mar 2024 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710605966; cv=none; b=M1Yb4GuweE1Ki0VmTTNooBuxNC4HTBl5MUWJrquE4HegfFD6gZL5saMlmhDmH5Azd2nKJP5Va4vqma1zOxo+GANcuwr8VEHRuJsGML5Y8VC8HiVWCogP6kM3IdLN3o+uDG9wCc7JgetXvvf7lSXj72C+eKG/jxRUiCoFb9hc8zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710605966; c=relaxed/simple;
	bh=+FhPLa0Rk5KaNidia6MCMfaPjXpKlOVaJgiPKSVbdE0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AI42VOhG3DsuXZX1uQTxKPLDXsVROFMsMGMRkWIsYHSaSfpD/0nkdfX4Z0PD+QiUwrb1Hb4nBx0rm2lJgjRw92VigPPF2McOG9RP6zzOD80euQY2r/9oxyK6zzh/GVmjZ9BU/R5GgNuRKPJNKTbaM0rAXb8gQKg51hqhuLIDbeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c85f86e4c7so257887339f.3
        for <linux-can@vger.kernel.org>; Sat, 16 Mar 2024 09:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710605964; x=1711210764;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uf6W3Zg2dvW4+JRL0J6TTi5aicDL8OJz3V+JIREMUJw=;
        b=DORaBEanu0/8L++AmdiRQLN3WsPnOFrjDaG5Htbu3x+f7/lW1ELyQTqnzfWyoicGjc
         Qv4laCMDe4UlY+R6nE9d1g4fQtmubKhF47XstDEdBrC71jtun1rTIanPLwBxhxfr2cTh
         0EjE/RnqLvUA4RwTVAuYm+CQ7XCQWPmQV2HOoIbpAY84h/TUZAeXDlq7gsHUGVHld3cV
         OzOm0B9tZWc5mDN0gw5qXHaerLPP6rmFjU89J0MI3N/JkFc/mlyEODoGlVoZ7G10c1Ko
         PKnU2BXCl20DZnlc1NgZ5a9b9075R21eEBFgOazJ8wV/VQMQsV2aQ92sS1U6W/Xsngo1
         PFgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFznIIw41uFHMkjkL2SsY/ZNBCW0wyG4v0TGbquXvaYnuDkbRdUQCcaZpKycG9nF38ydI0BoVM7gnbh9j7smBjXwdxf5OXyRd1
X-Gm-Message-State: AOJu0YzwOFjUxsir7IB92219hROej/OQUhs1F4lXFJ9tcXkFjgZ4H+a0
	Gy51VgjmpSjI5A4zUrN8UKB24BcPRp7nXNRWWb0jWKzqVHysKBmSBwxKnMPRCJsNgxSO2YmBecL
	mObGAxYeH2Uce4Zabd8GarCjjSgNRnGxVY9RLx+Z2N3H/kw7n4ADrjV8=
X-Google-Smtp-Source: AGHT+IGikfW01z7K2y5JnZchZJvcVj4AYhPuOoEanssKaWL9kn3ExakVmnSjQwzwrsbu+j3WDvlTX9f5sleigmep3j/fhRfGZ0VW
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:62a7:b0:476:f043:d34b with SMTP id
 fh39-20020a05663862a700b00476f043d34bmr237781jab.0.1710605963997; Sat, 16 Mar
 2024 09:19:23 -0700 (PDT)
Date: Sat, 16 Mar 2024 09:19:23 -0700
In-Reply-To: <00000000000067f65105edbd295d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5c35b0613c97c85@google.com>
Subject: Re: [syzbot] [can?] [bpf?] KMSAN: uninit-value in bpf_prog_run_generic_xdp
From: syzbot <syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, ben-linux@fluff.org, bp@alien8.de, 
	bpf@vger.kernel.org, daniel.sneddon@linux.intel.com, daniel@iogearbox.net, 
	dave.hansen@linux.intel.com, glider@google.com, hpa@zytor.com, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	mkl@pengutronix.de, netdev@vger.kernel.org, pbonzini@redhat.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, x86@kernel.org, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    66a27abac311 Merge tag 'powerpc-6.9-1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14285ac9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48bb382b96e7eda7
dashboard link: https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ab51c9180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127d21f1180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/37968fa0451e/disk-66a27aba.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5b288c5c3088/vmlinux-66a27aba.xz
kernel image: https://storage.googleapis.com/syzbot-assets/792ddbf8146d/bzImage-66a27aba.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in bpf_prog_run_generic_xdp+0x13a0/0x1ee0 net/core/dev.c:4876
 bpf_prog_run_generic_xdp+0x13a0/0x1ee0 net/core/dev.c:4876
 netif_receive_generic_xdp net/core/dev.c:4958 [inline]
 do_xdp_generic+0xb68/0x1440 net/core/dev.c:5017
 __netif_receive_skb_core+0x2533/0x6190 net/core/dev.c:5358
 __netif_receive_skb_one_core net/core/dev.c:5536 [inline]
 __netif_receive_skb+0xca/0xa00 net/core/dev.c:5652
 process_backlog+0x480/0x8b0 net/core/dev.c:5981
 __napi_poll+0xe7/0x980 net/core/dev.c:6632
 napi_poll net/core/dev.c:6701 [inline]
 net_rx_action+0x89d/0x1820 net/core/dev.c:6813
 __do_softirq+0x1c0/0x7d7 kernel/softirq.c:554
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:633 [inline]
 irq_exit_rcu+0x6a/0x130 kernel/softirq.c:645
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x83/0x90 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:702
 __preempt_count_dec_and_test arch/x86/include/asm/preempt.h:94 [inline]
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock_irqrestore+0x33/0x60 kernel/locking/spinlock.c:194
 unlock_hrtimer_base kernel/time/hrtimer.c:1021 [inline]
 hrtimer_start_range_ns+0x112c/0x11a0 kernel/time/hrtimer.c:1308
 hrtimer_start include/linux/hrtimer.h:275 [inline]
 j1939_tp_schedule_txtimer+0xc2/0x100 net/can/j1939/transport.c:702
 j1939_sk_send_loop net/can/j1939/socket.c:1164 [inline]
 j1939_sk_sendmsg+0x1a0e/0x2730 net/can/j1939/socket.c:1277
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:745
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x4a0 net/socket.c:2674
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was stored to memory at:
 pskb_expand_head+0x30f/0x19d0 net/core/skbuff.c:2253
 netif_skb_check_for_xdp net/core/dev.c:4921 [inline]
 netif_receive_generic_xdp net/core/dev.c:4952 [inline]
 do_xdp_generic+0x931/0x1440 net/core/dev.c:5017
 __netif_receive_skb_core+0x2533/0x6190 net/core/dev.c:5358
 __netif_receive_skb_one_core net/core/dev.c:5536 [inline]
 __netif_receive_skb+0xca/0xa00 net/core/dev.c:5652
 process_backlog+0x480/0x8b0 net/core/dev.c:5981
 __napi_poll+0xe7/0x980 net/core/dev.c:6632
 napi_poll net/core/dev.c:6701 [inline]
 net_rx_action+0x89d/0x1820 net/core/dev.c:6813
 __do_softirq+0x1c0/0x7d7 kernel/softirq.c:554

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_node+0x613/0xc50 mm/slub.c:3888
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:577
 __alloc_skb+0x35b/0x7a0 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1318 [inline]
 alloc_skb_with_frags+0xc8/0xbf0 net/core/skbuff.c:6504
 sock_alloc_send_pskb+0xa81/0xbf0 net/core/sock.c:2795
 sock_alloc_send_skb include/net/sock.h:1835 [inline]
 j1939_sk_alloc_skb net/can/j1939/socket.c:878 [inline]
 j1939_sk_send_loop net/can/j1939/socket.c:1142 [inline]
 j1939_sk_sendmsg+0xc0a/0x2730 net/can/j1939/socket.c:1277
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:745
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x4a0 net/socket.c:2674
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

CPU: 0 PID: 5044 Comm: syz-executor640 Not tainted 6.8.0-syzkaller-11136-g66a27abac311 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

