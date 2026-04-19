Return-Path: <linux-can+bounces-7373-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIs6N8jq5GnbbwEAu9opvQ
	(envelope-from <linux-can+bounces-7373-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 19 Apr 2026 16:46:32 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F75424680
	for <lists+linux-can@lfdr.de>; Sun, 19 Apr 2026 16:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B27130071F1
	for <lists+linux-can@lfdr.de>; Sun, 19 Apr 2026 14:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2CD2FF144;
	Sun, 19 Apr 2026 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b="TK4bA5tF"
X-Original-To: linux-can@vger.kernel.org
Received: from cse.ust.hk (cssvr7.cse.ust.hk [143.89.41.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D9E256C84;
	Sun, 19 Apr 2026 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=143.89.41.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776609988; cv=pass; b=JDZCD7DrgPL3e2VTFKz0c/CeQ+o8HYQlgghLDRL/P2I9/+XxgO0ZLd+hSTx8DqsD5Oon+g2AymGHK3oi1Ol0+klCmRLmwH0Zdqhs3oAiDoXwHlcWO6o8gI68Ze2Ig655daTWPR2ECyWrw7cqUkQ9WwW49iuq6GsQOf+S7tMgOWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776609988; c=relaxed/simple;
	bh=W0Yi/jKjkdOumZA0kY6WXZb4tF4lFUgdmaTA5I0DTsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpFWDC46Z/9N1ZVx8u+LFe0gxvr6zkyt9ishOphtofJTdtPfrpXkf4xzdyY3+Zynq4DRNkFWFMlkuJ9Y4jLfJ5Jm2+iFjCB5QtyeE1vXlB2/C0N8A1i5wxVD0gbw2ItId/bEhSwNzx+akaFdKaxZNRVJepJzD+TUXF6/ttDHF2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk; spf=pass smtp.mailfrom=cse.ust.hk; dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b=TK4bA5tF; arc=pass smtp.client-ip=143.89.41.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.ust.hk
ARC-Seal: i=1; d=cse.ust.hk; s=arccse; a=rsa-sha256; cv=none; t=1776609972;
	b=KHkLNAa5usPJo7JNGuXg2vqL6WVp1M86EN1hSu0gFgOlaXWrn0U/Trbtjql8ZZqy/oZ6
	 fnRHkXPBsqPnZ6GuFlbx9pMJOf1Nfm1b3vIy4eZsyOI7vw87oIVfOD5ZsCyFnEbLYS5+p
	 aU06JuvP3JJOyw4W9YrkLVLL8jksqCLWvg=
ARC-Message-Signature: i=1; d=cse.ust.hk; s=arccse; a=rsa-sha256;
	c=relaxed/relaxed; t=1776609972;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=wIGmvdtTCJS7SVbeAfhXCRJaAgbBLe30OWEaaRAy4iU=;
	b=BObVOUh2gqEXWzrTgMkMpMkXA5a9dYG6fMb+EpI3SbmPlJQEZRIuqgxSc/hQd5pNL44G
	 UScaJLP0CQBAeYymBTkQhQAMlPMuECNg2nW66lbyKzY0owU4yNNwpkluCOtj/XgG5nmpu
	 xkulcWmOB6FYlVtegw1CGwE1FkLx6eauck=
ARC-Authentication-Results: i=1; cse.ust.hk; arc=none smtp.remote-ip=143.89.191.45
Received: from chcpu16 (191host045.mobilenet.cse.ust.hk [143.89.191.45])
	(authenticated bits=0)
	by cse.ust.hk (8.18.1/8.12.5) with ESMTPSA id 63JEk5rj156449
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 19 Apr 2026 22:46:11 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cse.ust.hk;
	s=cseusthk; t=1776609972;
	bh=wIGmvdtTCJS7SVbeAfhXCRJaAgbBLe30OWEaaRAy4iU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TK4bA5tFrLMwzYqCtPC5b58ISztIcVEf3jQFhakZ2o30KWjlHddhYte8oowEsrwKZ
	 WwcKKiK/q/yIuPWRcAocEa56wmaTUnFsyTXg8vsp8VRfmgdhUrctHcC80r1sfzLbuU
	 sBtvVSV6N9UrdUFmunTJp5l4k3eDTIrQ+WxJVxoY=
Date: Sun, 19 Apr 2026 22:46:00 +0800
From: Shuhao Fu <sfual@cse.ust.hk>
To: Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] can: j1939: fix lockless local-destination check
Message-ID: <20260419144600.GA4091724@chcpu16>
References: <20260419140614.GA4041240@chcpu16>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419140614.GA4041240@chcpu16>
X-Env-From: sfual
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cse.ust.hk,none];
	R_DKIM_ALLOW(-0.20)[cse.ust.hk:s=cseusthk];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7373-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cse.ust.hk:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sfual@cse.ust.hk,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cse.ust.hk:dkim,ust.hk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 25F75424680
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Here is the userspace-triggered KCSAN setup I used locally to reproduce
the warning.

This is with a small KCSAN-only repro setup that makes the race easier
to observe, and the mechanism is explicit. On the writer side, right
after the real `priv->ents[0x80].nusers` update in
`j1939_local_ecu_get()` / `j1939_local_ecu_put()`, the test hook calls
`kcsan_check_write()` on that exact `nusers` slot, sets a
`writer_armed` flag, and spins for up to 20000 `cpu_relax()` iterations
waiting for a reader to show up. On the reader side, right before the
real `priv->ents[0x80].nusers` load in `j1939_tp_send()`, the matching
hook checks `writer_armed`, sets `reader_seen`, and calls
`kcsan_check_read()` on the same address. So the repro does not invent a
fake field or a fake access path; it keeps the real writer visible for
longer and asks KCSAN to watch the exact `nusers` slot, which makes the
existing race much easier to catch.

1. Build the kernel with the dedicated J1939 KCSAN config:

   ./tools/testing/kunit/kunit.py build \
     --arch=x86_64 \
     --kunitconfig=kernel/kcsan/j1939_userspace_race.kunitconfig \
     --build_dir=../out-j1939-userspace-kcsan \
     --make_options CC=clang-20 \
     --make_options LD=ld.bfd \
     --make_options AR=llvm-ar-20 \
     --make_options NM=llvm-nm-20 \
     --make_options OBJCOPY=llvm-objcopy-20 \
     --make_options READELF=llvm-readelf-20 \
     --make_options LLVM_IAS=1 \
     --jobs 8

2. Prepare a minimal initramfs with a static userspace helper and an
   `/init` script that enables KCSAN, narrows reporting to the J1939
   paths of interest, and runs the helper:

   mkdir -p /tmp/j1939-kcsan-userspace/initramfs/{bin,sbin,usr/bin,usr/sbin,proc,sys,dev,tmp}
   gcc -static -O2 -Wall -Wextra -pthread \
     -o /tmp/j1939-kcsan-userspace/initramfs/bin/j1939_kcsan_repro \
     tools/testing/selftests/net/can/j1939_kcsan_repro.c
   cp /usr/bin/busybox /tmp/j1939-kcsan-userspace/initramfs/bin/busybox
   for app in sh mount cat echo sync mkdir poweroff reboot; do
     ln -sf busybox /tmp/j1939-kcsan-userspace/initramfs/bin/$app
   done
   cp tools/testing/selftests/net/can/j1939_kcsan_init.sh \
     /tmp/j1939-kcsan-userspace/initramfs/init
   chmod +x /tmp/j1939-kcsan-userspace/initramfs/init
   (cd /tmp/j1939-kcsan-userspace/initramfs && \
     find . -print0 | cpio --null -o --format=newc | gzip -9 > ../initramfs.cpio.gz)

3. Boot the guest under QEMU:

   timeout 180 qemu-system-x86_64 \
     -accel tcg \
     -smp 4 \
     -m 2048 \
     -kernel out-j1939-userspace-kcsan/arch/x86/boot/bzImage \
     -initrd /tmp/j1939-kcsan-userspace/initramfs.cpio.gz \
     -append "console=ttyS0 rdinit=/init loglevel=7 ignore_loglevel panic=-1 kunit.enable=0 kcsan.early_enable=0" \
     -nographic \
     -no-reboot

4. The userspace helper then creates and brings up `vcan0`, runs one
   thread that repeatedly opens/binds/closes a J1939 socket on source
   address `0x80`, and runs two sender threads that bind to `0x81`,
   connect to destination `0x80`, and send 64-byte payloads so the
   kernel takes the TP path.

The exact trigger code is in
`tools/testing/selftests/net/can/j1939_kcsan_repro.c`. The core of it
is:

   static void *writer_thread(void *arg)
   {
           while (!stop_flag) {
                   int fd = open_j1939_socket();

                   bind_writer_socket(fd, WRITER_SRC_ADDR);
                   close(fd);
           }
   }

   static void *sender_thread(void *arg)
   {
           fd = open_j1939_socket();
           bind_sender_socket(fd, SENDER_SRC_ADDR);
           connect_sender_socket(fd, DEST_ADDR);

           while (!stop_flag)
                   send(fd, payload, sizeof(payload), 0);
   }

   int main(void)
   {
           pthread_create(&writer, NULL, writer_thread, NULL);
           pthread_create(&sender1, NULL, sender_thread, NULL);
           pthread_create(&sender2, NULL, sender_thread, NULL);
           nanosleep(&req, NULL);
   }

With that setup I reproduced:

   BUG: KCSAN: data-race in j1939_local_ecu_put / j1939_tp_send

In the actual rerun log I got locally, this was not a one-off hit. The
same warning appeared twice in one run, first at line 9430 and then
again at line 9625, both on the same 4-byte address
`0xffffa432c216c828`.

The first hit was:

   read-write to 0xffffa432c216c828 of 4 bytes by task 66 on cpu 2:
    j1939_local_ecu_put+0x50/0x2d0
    j1939_sk_release+0x2e2/0x450
    sock_close+0x57/0x120
    __fput+0x218/0x480
    fput_close_sync+0x9c/0x130
    __x64_sys_close+0x51/0x90

   read to 0xffffa432c216c828 of 4 bytes by task 68 on cpu 3:
    j1939_tp_send+0x1ae/0x3d0
    j1939_sk_sendmsg+0x57b/0x8a0
    __sys_sendto+0x274/0x280
    __x64_sys_sendto+0x71/0x90
    x64_sys_call+0x2d35/0x3020
    do_syscall_64+0xc7/0x300

The second hit in the same run reported the same pair again:

   read-write to 0xffffa432c216c828 of 4 bytes by task 66 on cpu 2:
    j1939_local_ecu_put+0x50/0x2d0
    j1939_sk_release+0x2e2/0x450
    sock_close+0x57/0x120
    __fput+0x218/0x480

   read to 0xffffa432c216c828 of 4 bytes by task 68 on cpu 3:
    j1939_tp_send+0x1ae/0x3d0
    j1939_sk_sendmsg+0x57b/0x8a0
    __sys_sendto+0x274/0x280
    __x64_sys_sendto+0x71/0x90

The outer `timeout` eventually kills QEMU, but these KCSAN reports are
emitted well before that.

Thanks,
Shuhao


On Sun, Apr 19, 2026 at 10:06:35PM +0800, Shuhao Fu wrote:
> j1939_priv.ents[].nusers is documented as protected by priv->lock, and
> its updates already happen under that lock. j1939_can_recv() also reads
> it under read_lock_bh(). However, j1939_session_skb_queue() and
> j1939_tp_send() still read priv->ents[da].nusers without taking the
> lock.
> 
> Those transport-side checks decide whether to set J1939_ECU_LOCAL_DST, so
> they can race with j1939_local_ecu_get() and j1939_local_ecu_put() while
> userspace is binding or releasing sockets concurrently with TP traffic.
> This can misclassify TP/ETP sessions as local or remote and take the wrong
> transport path.
> 
> Fix both transport paths by routing the destination-locality check through
> a helper that reads ents[].nusers under read_lock_bh(&priv->lock).
> 
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
> ---
>  net/can/j1939/transport.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index df93d57907da7e..8a31cb23bc76d0 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -351,6 +351,18 @@ static void j1939_session_skb_drop_old(struct j1939_session *session)
>  	}
>  }
>  
> +static bool j1939_address_is_local(struct j1939_priv *priv, u8 addr)
> +{
> +	bool local = false;
> +
> +	read_lock_bh(&priv->lock);
> +	if (j1939_address_is_unicast(addr) && priv->ents[addr].nusers)
> +		local = true;
> +	read_unlock_bh(&priv->lock);
> +
> +	return local;
> +}
> +
>  void j1939_session_skb_queue(struct j1939_session *session,
>  			     struct sk_buff *skb)
>  {
> @@ -359,8 +371,7 @@ void j1939_session_skb_queue(struct j1939_session *session,
>  
>  	j1939_ac_fixup(priv, skb);
>  
> -	if (j1939_address_is_unicast(skcb->addr.da) &&
> -	    priv->ents[skcb->addr.da].nusers)
> +	if (j1939_address_is_local(priv, skcb->addr.da))
>  		skcb->flags |= J1939_ECU_LOCAL_DST;
>  
>  	skcb->flags |= J1939_ECU_LOCAL_SRC;
> @@ -2038,8 +2049,7 @@ struct j1939_session *j1939_tp_send(struct j1939_priv *priv,
>  		return ERR_PTR(ret);
>  
>  	/* fix DST flags, it may be used there soon */
> -	if (j1939_address_is_unicast(skcb->addr.da) &&
> -	    priv->ents[skcb->addr.da].nusers)
> +	if (j1939_address_is_local(priv, skcb->addr.da))
>  		skcb->flags |= J1939_ECU_LOCAL_DST;
>  
>  	/* src is always local, I'm sending ... */
> -- 
> 2.25.1

