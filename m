Return-Path: <linux-can+bounces-5962-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EDFCE83BF
	for <lists+linux-can@lfdr.de>; Mon, 29 Dec 2025 22:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5F0B300B90F
	for <lists+linux-can@lfdr.de>; Mon, 29 Dec 2025 21:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1E454758;
	Mon, 29 Dec 2025 21:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="YZjdjNZI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="ltYQMkvq"
X-Original-To: linux-can@vger.kernel.org
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEFD3A1E63
	for <linux-can@vger.kernel.org>; Mon, 29 Dec 2025 21:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767044935; cv=pass; b=qRWyoiFq4+QFHV43s+SgdbIGs/uIF2JbLSeprWs0M3rETpj+mylKnGM/TTSXfsl34HowkH4hTF7I27FNmt7IbVOH0AqOU5tPtlmSGh5/2q9umz+QDrX+X982lgydM/+zWInZRn4ttgnrxXJw3jxAlv+ssex6857eIgBOwEGvTiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767044935; c=relaxed/simple;
	bh=njSEgaJpM7aFcob4ZfKjZckAVbtjUFV47r+aCCHO3Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5k+22LlQpJ/TDZs/1IRKlGE8g8Fb7OOxtqPpqXr4mScgbcMx6yFCMYbjJsFp+MhO8uyI+Mvhzr22mGXdMTULzpyHqKL/IRREHAOhgqvuCHUAsHtJ1JIjPFGDfeHlhLn76DPG5kDDufxwzHm93fpeYy1qVHLsnMKNmZB8ixhiYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=YZjdjNZI; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=ltYQMkvq; arc=pass smtp.client-ip=185.56.87.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-dx26.prod.antispam.mailspamprotection.com; s=arckey; t=1767044932;
	 b=b7JXdM/tA+0UOgtIjjPDcCEdwlkx1MzBvClOfACtxqoibalB+hSGeZPXHZeaemkBViagR0CWbT
	  X7r2rjBPYOmjDtFOpqurDV21sKU9SYhs5Yxh9TW5L2O8GZgxl4qC5aWo8sP2rY3AhWeVXus97S
	  0Ew7FHGcI2BeFGQwk3jzVUKBqSj6RhF7l3zfbGS5NpdJhAuNtmPkVmRV4ZBuE2/viGBq/Ej6fx
	  WSXBVQdng3dSpujMp2pOGrUmeOZbA9TRWb1tRHGiFLz/vhjQHhrO9d93SkWhuMyjc3hGln8JPz
	  5EfRfzqBhws0hcU9twXRrLlVqHLbmKZtPmCR734vvNi3PA==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-dx26.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-dx26.prod.antispam.mailspamprotection.com; s=arckey; t=1767044932;
	bh=njSEgaJpM7aFcob4ZfKjZckAVbtjUFV47r+aCCHO3Hw=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=nTMnKEoORqu6hQqN0ex/nJSSFl3Dr54iNs30vE3dIq0htYCQZqOLV4pDiQgdbRkfaGlw6NrbgH
	  E/ZDYd7/42XhqHbLxHkw+ixFElmryB1WnsEMs0vMl0lUKCMqSgzfqfyEyHQ8rohvkNFsujL1pk
	  AKBvMhzqpPwKkXjYH1KTJPMFUs1zi56DOjycJ17c/pPzUMuI1MLcIBClwJLwEzTBvvE5wupgBQ
	  ujMqDCVpNIn1CgTaDigbRdzZeaen0hUv+0aHrGn4YICdq3pbchoRKp6xG5nMFPvYwNnuAAH9aD
	  0DCarFfjrFR3RJpSud9uSH00wqrNYO3i95HLWWCEESV2TA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=JeAM4nWTpcUtADM4VJ4nzpi2Ew5kVIMLOrtrf3VwIPA=; b=YZjdjNZIVu+zQg6HlM49Pn0/hH
	frJlFWLYIJNkxBV18vfvAGyPayjrVIysBdUr6MiHQo0XeVt2y1s2Q6MmRlSIT91QGPnECSHgM9tCV
	paqmjQ/xAqjwx5AE8iiMe6VTqii9JsVkel0eb/0z05kv/OLlm6F4m9BeTEA5n25+0kdY=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-2fc8.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vaKHg-00000001Cwz-1Bri
	for linux-can@vger.kernel.org;
	Mon, 29 Dec 2025 20:56:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=JeAM4nWTpcUtADM4VJ4nzpi2Ew5kVIMLOrtrf3VwIPA=; b=ltYQMkvqxx4tzd/ntoKjZwrW6h
	iOE+bIqwyF4FcX5vW029HCyMEpSkQXRShlZDXfgUcw8X0qjDOArQ7C8epVKOgIP1IkBDWzTPRCqEc
	4YZoO1kxwsEzDeH1kcvg2pkWJVeVfeNrdYpyUIxHVxRDY/IW0sNB98KLdCLMuIeoDsyo=;
Received: from [95.248.141.113] (port=62969 helo=bywater)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vaKHQ-00000000BS5-1TCH;
	Mon, 29 Dec 2025 20:55:52 +0000
Date: Mon, 29 Dec 2025 21:55:50 +0100
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
Message-ID: <aVLq1ibPcPHk-7Qv@bywater>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora>
 <aT7XAsTWr0_yyfx_@bywater>
 <aVLOPMmpvArnVAHZ@fedora>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVLOPMmpvArnVAHZ@fedora>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: f24e5196068f6d0007b6353e72d9aad0
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vaKHg-00000001Cwz-1Bri-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-dx26.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hi Matias,

On Mon, Dec 29, 2025 at 07:53:48PM +0100, Matias Ezequiel Vara Larsen wrote:
> > While stress testing this, I noticed that flooding the virtio-can
> > interface with packets leads to an hang of the interface itself.
> > I am seeing this issuing, at host side:
> > 
> > 	while true; do cansend can0 123#00; done
> > 
> > with:
> > 
> >  - QEMU: the tip of the master branch plus [2]
> >  - vhost-device: the tip of the main branch
> > 
> > and the following QEMU invocation:
> > 
> > qemu-system-x86_64 -serial mon:stdio \
> >     -m 2G -smp 2 \
> >     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
> >     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
> >     -append "loglevel=7 console=ttyS0" \
> >     -machine memory-backend=pc.ram \
> >     -object memory-backend-file,id=pc.ram,size=2G,mem-path=/tmp/pc.ram,share=on \
> >     -chardev socket,id=can0,path=/tmp/sock-can0 \
> >     -device vhost-user-can-pci,chardev=can0
> > 
> > 
> > Restarting the interface (i.e.: ip link set down and the up) does not
> > fix the situation.
> > 
> > I'll try to do some more testing during the next days.
> 
> I tried this and I could not reproduce it. [2] requires a minimal change
> to apply, i.e., qdev-properties.h has changed to /core. I'll send a v2
> for that. I used latest vhost-device-can. I run `candump can0` in the
> guest and `while true; do cangen vcan0; done` in the host. Am I missing
> something?

With the plain 'cangen' you are not really flooding the interface, since
you are only sending a random CAN frame every 200ms. The only way I can
reproduce this behaviour in a consistent manner is running from the host:

    while true; do cansend vcan0 134#00; done

which seems to generate the maximum amount of traffic.

This is not of course a realistic bus load, but is leading the system
(at least on my setup) to a corner case somewhere.

> 
> Thanks,
> 
> Matias
> 
> 

Thank you for this effort!

Regards,
Francesco


