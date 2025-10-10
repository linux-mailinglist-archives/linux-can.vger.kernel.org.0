Return-Path: <linux-can+bounces-5121-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 027E9BCE9A8
	for <lists+linux-can@lfdr.de>; Fri, 10 Oct 2025 23:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2E234E8AB5
	for <lists+linux-can@lfdr.de>; Fri, 10 Oct 2025 21:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F8E258CF2;
	Fri, 10 Oct 2025 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="I6Mvph+L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="a4soGJk2"
X-Original-To: linux-can@vger.kernel.org
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB962594BD;
	Fri, 10 Oct 2025 21:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760131253; cv=pass; b=qK5caUpkQChj07iEU1IZHQEwmeb9wbvWyBvSOjNKXQnSAUeG3vFn9ycAiW0wobTOA0v1pe6O7kEhfoJgaFOB+1iHSwk16kYKS5UQ1LY4+k7LcceGCvaaSN4qb/UUaLisymU9IrPNCOB2Tny4ysBw6NI7QQoiCaynXj5LK8yDpZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760131253; c=relaxed/simple;
	bh=fPlDHZlSJRA5PDvHco57sjg3ozHSO1I20UpOSkNVqQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAvVo5AbMLBEbc8GXSn6GFLIShFQDxBbgrUO9BakptF0EHYTY+RJLRk2biH5lKtxAGo+udoLeEpfoQTVTXm4Tp0l/+Ze3LKVkWu68/po64w7bGLoil1QBFwoPiwjMm8ezWT/WbBufuBu+RtsCwxEFIdK56X04RDQg5GLISw3r84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=I6Mvph+L; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=a4soGJk2; arc=pass smtp.client-ip=185.56.87.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-x65p.prod.antispam.mailspamprotection.com; s=arckey; t=1760131251;
	 b=hNSFIuR//PUjBb8UppfHT1xpEArShO1AA3kogNyDosQQe55YXx1ZbgxisJKYz2yG3W7jk6wCQu
	  fRigJ1/6y8Y5WZ2OnheL9Ca5AI11wKLNjS18WMRKJw4XpmMn5jJ4loDwKIW5L2CfTEo6qTz5uV
	  GSU2DIn5ycIjdkkcArhxFQSZeipLJ9PiJkQORQTfMiewDN6skAyyPBFZd6Uh7MPMWxOTaHtV7u
	  hAJjtOFrdpLO86vzGrRs31fcYyXsiE5LiVPc84mm+VA1giK60UiFLq9C3qM9JLI6msA5sSq6+w
	  S7cmP+uvBpvPlyQ3bvRnWGiDjNpImYSipmxO7TWQMzDa1Q==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-x65p.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-x65p.prod.antispam.mailspamprotection.com; s=arckey; t=1760131251;
	bh=fPlDHZlSJRA5PDvHco57sjg3ozHSO1I20UpOSkNVqQI=;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	  Message-ID:Date:Subject:Cc:To:From:DKIM-Signature:DKIM-Signature;
	b=E0723+QxCuGANTCDJnbXreUWwOPl4rUQbkIt62/6waonxjGGX4DeRr5tvwrbdcCab1gTUJ/vT9
	  ECsyRd4ZEA+rhZ5Mb+V9ZYIhs2wM0dmIWlJJj2Y5jzAUyfVOnpIXBhanRCOgJjcdx65NIF2wT+
	  DSSxrx25oI4b3rrKWbr+hgCv3vmi4N+yBp/GMkcfMoKSTgyXWYQppAyF6tJvbj/DpLheMEVG2E
	  eozAwJ5kTonnp7Wz/DwFK33iPSS4m56oPNhD9oiQvCWwMGqv41KOS/ikDKx/zJHS+qyqMJgxiz
	  SwzKvBu5r/idTjq+bnCQbkJ83fhwSD+1VNem9wVUCQG6Dg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Reply-To:List-Unsubscribe;
	bh=Pa3D+kH4AJps3m5pvh+XsXvkn2PadB4zax/ER5QUhaU=; b=I6Mvph+La2JGmY6g6TZCwRDd8d
	vJX2GUgna8IUdd+Ltr0b5+GbxNmbfdLofQM3zsEH7m+BcnTC1BnJzSrp0xCQjvMP+z8kxkbpv6BPN
	L+vrvipBf53plAGo18iO94vQzRnOEpeDYYn7SmSlAltJYiJRPcjr26chw3S+2gT9hYaA=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-x65p.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v7KXY-00000008i49-08Me;
	Fri, 10 Oct 2025 21:20:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=Pa3D+kH4AJps3m5pvh+XsXvkn2PadB4zax/ER5QUhaU=; b=a4soGJk2euqlfaLc6adf+mUjUX
	2jNarlk/C/D5cX3Ig9UyytaSOhwu83PqdoS/XtcmZ4plVMKykP/nlbqJCnRsR0sqxCf0H3736eJxa
	PCNBpc7B4jQABd+kVG7cZmQl5wmPuW962CXROBvVoBdNwYRQJ3tdOjQPdRRbNGWAR1PI=;
Received: from [87.16.13.60] (port=59834 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v7KXH-00000000PLJ-0N73;
	Fri, 10 Oct 2025 21:20:23 +0000
From: Francesco Valla <francesco@valla.it>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 Harald Mommer <harald.mommer@opensynergy.com>,
 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
 Wolfgang Grandegger <wg@grandegger.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 development@redaril.me
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Date: Fri, 10 Oct 2025 23:20:22 +0200
Message-ID: <2318164.vFx2qVVIhK@fedora.fritz.box>
In-Reply-To: <aOkqUWxiRDlm0Jzi@fedora>
References:
 <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <2243144.yiUUSuA9gR@fedora.fritz.box> <aOkqUWxiRDlm0Jzi@fedora>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: a9073c73fb2f04c10de87ad2a155623d
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1v7KXY-00000008i49-08Me-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-x65p.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Friday, 10 October 2025 at 17:46:25 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> > Hello Mikhail, Harald,
> > 
> > hoping there will be a v6 of this patch soon, a few comments:
> > 
> 
> I am working on the v6 by addressing the comments in this thread.
> 
> > On Monday, 8 January 2024 at 14:10:35 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:
> > 
> > [...]
> > 
> > > +
> > > +/* virtio_can private data structure */
> > > +struct virtio_can_priv {
> > > +	struct can_priv can;	/* must be the first member */
> > > +	/* NAPI for RX messages */
> > > +	struct napi_struct napi;
> > > +	/* NAPI for TX messages */
> > > +	struct napi_struct napi_tx;
> > > +	/* The network device we're associated with */
> > > +	struct net_device *dev;
> > > +	/* The virtio device we're associated with */
> > > +	struct virtio_device *vdev;
> > > +	/* The virtqueues */
> > > +	struct virtqueue *vqs[VIRTIO_CAN_QUEUE_COUNT];
> > > +	/* I/O callback function pointers for the virtqueues */
> > > +	vq_callback_t *io_callbacks[VIRTIO_CAN_QUEUE_COUNT];
> > > +	/* Lock for TX operations */
> > > +	spinlock_t tx_lock;
> > > +	/* Control queue lock. Defensive programming, may be not needed */
> > > +	struct mutex ctrl_lock;
> > > +	/* Wait for control queue processing without polling */
> > > +	struct completion ctrl_done;
> > > +	/* List of virtio CAN TX message */
> > > +	struct list_head tx_list;
> > > +	/* Array of receive queue messages */
> > > +	struct virtio_can_rx rpkt[128];
> > 
> > This array should probably be allocated dynamically at probe - maybe
> > using a module parameter instead of a hardcoded value as length? 
> > 
> 
> If I allocate this array in probe(), I would not know sdu[] in advance
> if I defined it as a flexible array. That made me wonder: can sdu[] be
> defined as flexible array for rx? 
> 
> Thanks.
> 

One thing that can be done is to define struct virtio_can_rx as:

struct virtio_can_rx {
#define VIRTIO_CAN_RX                   0x0101
	__le16 msg_type;
	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
	__u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
	__u8 padding;
	__le16 reserved_xl_priority; /* May be needed for CAN XL priority */
	__le32 flags;
	__le32 can_id;
	__u8 sdu[] __counted_by(length);
};

and then allocate the rpkt[] array using the maximum length for SDU:

priv->rpkt = kcalloc(num_rx_buffers,
		sizeof(struct virtio_can_rx) + VIRTIO_CAN_MAX_DLEN,
		GFP_KERNEL);

In this way, the size of each member of rpkt[] is known and is thus
suitable for virtio_can_populate_vqs().


Regards,

Francesco



