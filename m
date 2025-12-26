Return-Path: <linux-can+bounces-5939-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60969CDED5F
	for <lists+linux-can@lfdr.de>; Fri, 26 Dec 2025 18:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BC173000B0D
	for <lists+linux-can@lfdr.de>; Fri, 26 Dec 2025 17:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672D02DA758;
	Fri, 26 Dec 2025 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="XKCZSuVM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="FAt1PuPp"
X-Original-To: linux-can@vger.kernel.org
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45795139D0A
	for <linux-can@vger.kernel.org>; Fri, 26 Dec 2025 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766768465; cv=pass; b=cXnZsoPpshcjBENlQJQGppG0TsU6OoX5Z7kq5GcaLgz9IBd9+mmw6XjA0hH6sBn0ubQlidI8tRp4HESZS+Ws6CJTcp8E13IgkMDnooPfRP9VPzw1M595w98nIS/5mUAA8WceniRtUCzlgu2or+65vZfjAIRurSlsWrVptfMIDRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766768465; c=relaxed/simple;
	bh=PLfOrXsKuXPJbF/ozmzSAqxXmkRHY1fuhDYqZjyePGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3lCHF9L+padePAiz/I74RPIIU1IGCFqnQlQdkR1M8k1Rwc7MvMBLeqvNfMRsGfgNB2IZQormfzjCcO3b7h7Iq4wcWVzPlJ/DsWbq26zB32S6bm9xNw69EiWt6EZRj0R0zBDhqCdRJPbWoxYSnRaPuUrKlRDulYFekd5q3iDZGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=XKCZSuVM; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=FAt1PuPp; arc=pass smtp.client-ip=185.56.87.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-l3wl.prod.antispam.mailspamprotection.com; s=arckey; t=1766768461;
	 b=bS5+ThRO9jWR5Hbk3rr4qekvybtYBu2Uc3AClPrPFZ3t8oai4cxiDNZTZ++kfPy/gqKsrj9cy+
	  KDUusBaAnfTZZA7f1yUw3PDlYqLPEUHFplnfTKLVRn9iZDp35B8yxAMb3CJ2p0mk9sdiDVVZkQ
	  HuiNsnzchzBVX/heBaZ27broXdxr149DQX+a2V5fo52Kiy4tqpYpHc89Mm3ccf6KLCiSZcJGnG
	  5OKy2P8OiBBQcP0a9T4FrI/c81Oa+fq1+ffaUJNkrV3JIU2i1VpDUGJoYU5l2ncW8ALGMAYX7R
	  cx04FtVlzRrhCCwt5jz4NOfTSGxQ0SRryWZPGtIDXhGa5A==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-l3wl.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-l3wl.prod.antispam.mailspamprotection.com; s=arckey; t=1766768461;
	bh=PLfOrXsKuXPJbF/ozmzSAqxXmkRHY1fuhDYqZjyePGk=;
	h=In-Reply-To:Content-Description:Content-Type:MIME-Version:References:
	  Message-ID:Subject:Cc:To:From:Date:DKIM-Signature:DKIM-Signature;
	b=KWVGXE9LelBP/elOtXOIem/aggdeGwBMt8evb9ZehXs5eXsKcovUX9JmNRjQvCt0xc3VZnF0DW
	  MAD2w+Ppnot+2uB3Gg3WElS6KVSVN696e5TON+gmstqCEOdCQTAwnf6v8BBReGWieSgzuvlz0N
	  xJa2pELTDRow2BpMv2WwnjGjJyhb6RxKnK1d+daBiHDr7bhsYLtkf7Fc/a7ixPFKl6EvcxNqEk
	  7tGVrO1Vxwdef6Sga0R2vLEh43LpPtMMHpBpQwYVguCGhHFdlFj92ZpfASrLDrgT9e0tFHCYPD
	  iVKHZ6UKuwhfrqrosetUjo2GkapfXnzn3Q52dIBMvwhKTw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=GmElzA9wpYCBzsDOe8cwU9sQH0JD1wOish4AaZbWI0I=; b=XKCZSuVMFTCwjlekvkloG10MJN
	bxBzCkWxhMK/hw/aQWxhImeuBpSRapBIP5wUIWQt92IRT/0I8Rr3Sxp9lw0mHmZZEnr6HUw+ySPvs
	JFwpB5BJUeDh70nuo6fJ3i7VjDbG1xjFvPMMTZ/pz7zRsfyWPxubMgbTingBweD9e2lE=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-0cn6.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vZ9RI-0000000CfRz-1wJ0
	for linux-can@vger.kernel.org;
	Fri, 26 Dec 2025 15:09:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=GmElzA9wpYCBzsDOe8cwU9sQH0JD1wOish4AaZbWI0I=; b=FAt1PuPpIBFcXVZiYVaPhRtkJP
	5G+1JTMZ8vrbWxxA1KFItn+Inf5DBoLQ9lrbYGCgOpPAwQEn0dBMz8cS6DsKxm7M2+3D01ZZzYl4Z
	QKOUPlpEta6BMePXTMB0XmVRptmDOFlcemWVqVuvB4JlTFgzs23RW/UGWu3m7yunpgVk=;
Received: from [95.248.141.113] (port=62022 helo=bywater)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vZ9R3-00000000Mx9-3X9B;
	Fri, 26 Dec 2025 15:08:57 +0000
Date: Fri, 26 Dec 2025 16:08:56 +0100
From: Francesco Valla <francesco@valla.it>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
Message-ID: <aU6lCL_vrF93lpYa@bywater>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora>
 <aT7XAsTWr0_yyfx_@bywater>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: 
Content-Disposition: inline
In-Reply-To: <aT7XAsTWr0_yyfx_@bywater>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: eac6f005dad715759effd28d60828cdf
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vZ9RI-0000000CfRz-1wJ0-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-l3wl.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hi,

On Sun, Dec 14, 2025 at 04:25:54PM +0100, Francesco Valla wrote:
> While stress testing this, I noticed that flooding the virtio-can
> interface with packets leads to an hang of the interface itself.
> I am seeing this issuing, at host side:
> 
> 	while true; do cansend can0 123#00; done
> 
> with:
> 
>  - QEMU: the tip of the master branch plus [2]
>  - vhost-device: the tip of the main branch
> 
> and the following QEMU invocation:
> 
> qemu-system-x86_64 -serial mon:stdio \
>     -m 2G -smp 2 \
>     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
>     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
>     -append "loglevel=7 console=ttyS0" \
>     -machine memory-backend=pc.ram \
>     -object memory-backend-file,id=pc.ram,size=2G,mem-path=/tmp/pc.ram,share=on \
>     -chardev socket,id=can0,path=/tmp/sock-can0 \
>     -device vhost-user-can-pci,chardev=can0
> 
> 
> Restarting the interface (i.e.: ip link set down and the up) does not
> fix the situation.
> 
> I'll try to do some more testing during the next days.

After a deep dive, I _think_ the problem actually lies in vhost-device,
since it is not there (or al least, it seems so) using an alternative
implementation that uses the qemu socketcan support [0] (implementation
which builds on top of the work done by Harald and Mikhail):

qemu-system-x86_64 -serial mon:stdio \
    -m 2G -smp 2 -enable-kvm \
    -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
    -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
    -append "loglevel=7 console=ttyS0" \
    -object can-bus,id=canbus0 -object can-host-socketcan,id=canhost0,if=vcan0,canbus=canbus0 \
    -device virtio-can-pci,canbus=canbus0

Unfortunately, my Rust knoweledge is not sufficient to understand the
vhost-device implementation [1]; the issue seems to be related to the
host->guest vring becoming empty and not refilling anymore.

Regards,
Francesco

[0] https://github.com/WallaceIT/qemu/tree/virtio-can
[1] https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-can


