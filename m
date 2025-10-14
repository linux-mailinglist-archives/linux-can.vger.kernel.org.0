Return-Path: <linux-can+bounces-5194-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F95FBDA8DC
	for <lists+linux-can@lfdr.de>; Tue, 14 Oct 2025 18:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C8265039B8
	for <lists+linux-can@lfdr.de>; Tue, 14 Oct 2025 16:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5D030170B;
	Tue, 14 Oct 2025 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="wwjOp8Yv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="IegT3koj"
X-Original-To: linux-can@vger.kernel.org
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6AC3009DD;
	Tue, 14 Oct 2025 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760457711; cv=pass; b=NNSX6g4IC4q1fo4lBOJMhLpql1UYbXfcEUEw7MrPoIr2GHtWziYRXdB1YipeGuRS6Gz14kaMzbwmq1BJuWuwJ18VmYOFQqPFg+jKn+U3xLvv6quLQ96dizA86ojxW9POjWp2fNew9n/aB4F11uo2i7+mqFaHO9DWKy+1BrA37SQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760457711; c=relaxed/simple;
	bh=qLEHI8X92rzJVvNe3sz2L6E08H2+TevfCQD5cWiQSTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=biUTxAQ4YcRMfk+jT180kBxx7gBnPlm6hAvwaizFDlK/bU4yt1+kA51AR4WeaULC3Un2RSN4g4l31woRtGvp6DwFnw5lERbzmEIRZn/QUjv6Jy0YxHsarrJtaWXN1Zmd7QLX/Y8GLXRQA5aS0RFdoOajBltXT44lkHcnpOtHodI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=wwjOp8Yv; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=IegT3koj; arc=pass smtp.client-ip=185.56.87.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-s3hj.prod.antispam.mailspamprotection.com; s=arckey; t=1760457710;
	 b=u+RGO511c/NQC3PQJt93GRy8I5/xVPTZ9Jlh6NTFbw/wMjovJIG8d7o9t97bj6NDZuEM+aH3IS
	  ouTwBdttLy885Uv02jBz92xZ/NbRmMS9ryxEO53+qqN33jP2Km3XaD7PL5kUCqYQPqKPM5hfLH
	  hlNHuRLRcJAUxT4uF2lMkLWaZGzMOWH/6fzYifu8HrswqlVOTwWO4blFk/D7aqvPoFfGuwkrUk
	  1AxOm5PdoKkgNTECc2fKM/cIQGHFoU0n86pfUPWn6Uzz3PhoMZnzgENqapw4027Sj3r/2A4SVP
	  vBSdRjOL7ablUj7yH7qqPIVJVkSuIWDghUtK4wxeo0Agvg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-s3hj.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-s3hj.prod.antispam.mailspamprotection.com; s=arckey; t=1760457710;
	bh=qLEHI8X92rzJVvNe3sz2L6E08H2+TevfCQD5cWiQSTY=;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	  Message-ID:Date:Subject:Cc:To:From:DKIM-Signature:DKIM-Signature;
	b=fApZEgvl1k6LUWPcpLTvVDCWsasYxKDNlTua4nad9Zocc9YDYY3gVwUZ3rrwvbh4LFCCSNhuVX
	  d36sSBLFzj9RlUJF8Uit4E3YG/zTgOLn0u/MJ3tnYBHn2wbYasuFFLbc5HaZLeSnDgAVGt+aEX
	  YQ6LUnUuDpHjwbOP0IcIx987LJgeSPFmoRvy84BXm4iBlBRideFKcFlA+P6L7YxJuYpuEfTsWX
	  hbIRq20hhBgfUj+SssY2A2X1StzGXb+0sbZyJhL43MJpT/rvRrhdNwC6+rj+IRtJrY9lQSduFk
	  5QNG2tOIy4zr23CozSGkm2A3jOS75Ba79SWZENqlA7vEiQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Reply-To:List-Unsubscribe;
	bh=JxnkS9Xl8ClOOgOP8ITCaK9nVGvTdorwPDwhCQjD3DA=; b=wwjOp8YvufxLnVrspryK7V6w7Z
	V/PGdbm9KGvyg0RifIor2Tbw871hn4gVFtFFc4fnGtOZeqZyxTlVsZKWum4wkkfXNsmxbulxuokTV
	qoCaJ+xmvWi35omJNlwOwyBdY0ug7N+k383aU5CuZrGboTUzpcxQrAs7MP9aWbBSCTKk=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-s3hj.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v8hT5-00000001rNs-1i14;
	Tue, 14 Oct 2025 16:01:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=JxnkS9Xl8ClOOgOP8ITCaK9nVGvTdorwPDwhCQjD3DA=; b=IegT3kojrdmO1lVOS4CJKRgmIQ
	Ku/3vNp3AcCq47IJz59MMmZPIzaCehDt/+PZ/E11cYe7tguhrjZY3XhHa6pdoSyBfKB0KFT/RB65g
	Y/OAPrp5c+DmC+SibBLuNbgYd1/pd88fzBGMutKkhYbE+8pGufNP9zN7A/nlbDbZmzS0=;
Received: from [87.16.13.60] (port=63204 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v8hSW-00000000HlS-1DDE;
	Tue, 14 Oct 2025 16:01:08 +0000
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
Date: Tue, 14 Oct 2025 18:01:07 +0200
Message-ID: <1997333.7Z3S40VBb9@fedora.fritz.box>
In-Reply-To: <aO4isIfRbgKuCvRX@fedora>
References:
 <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <2243144.yiUUSuA9gR@fedora.fritz.box> <aO4isIfRbgKuCvRX@fedora>
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
X-SGantispam-id: 17455a6c8a999985856092c8447c12d4
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1v8hT5-00000001rNs-1i14-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-s3hj.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Tuesday, 14 October 2025 at 12:15:12 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> > Hello Mikhail, Harald,
> > 
> > hoping there will be a v6 of this patch soon, a few comments:
> > 
> > On Monday, 8 January 2024 at 14:10:35 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:
> > 
> > [...]
> > > +
> > > +/* Compare with m_can.c/m_can_echo_tx_event() */
> > > +static int virtio_can_read_tx_queue(struct virtqueue *vq)
> > > +{
> > > +	struct virtio_can_priv *can_priv = vq->vdev->priv;
> > > +	struct net_device *dev = can_priv->dev;
> > > +	struct virtio_can_tx *can_tx_msg;
> > > +	struct net_device_stats *stats;
> > > +	unsigned long flags;
> > > +	unsigned int len;
> > > +	u8 result;
> > > +
> > > +	stats = &dev->stats;
> > > +
> > > +	/* Protect list and virtio queue operations */
> > > +	spin_lock_irqsave(&can_priv->tx_lock, flags);
> > > +
> > > +	can_tx_msg = virtqueue_get_buf(vq, &len);
> > > +	if (!can_tx_msg) {
> > > +		spin_unlock_irqrestore(&can_priv->tx_lock, flags);
> > > +		return 0; /* No more data */
> > > +	}
> > > +
> > > +	if (unlikely(len < sizeof(struct virtio_can_tx_in))) {
> > > +		netdev_err(dev, "TX ACK: Device sent no result code\n");
> > > +		result = VIRTIO_CAN_RESULT_NOT_OK; /* Keep things going */
> > > +	} else {
> > > +		result = can_tx_msg->tx_in.result;
> > > +	}
> > > +
> > > +	if (can_priv->can.state < CAN_STATE_BUS_OFF) {
> > > +		/* Here also frames with result != VIRTIO_CAN_RESULT_OK are
> > > +		 * echoed. Intentional to bring a waiting process in an upper
> > > +		 * layer to an end.
> > > +		 * TODO: Any better means to indicate a problem here?
> > > +		 */
> > > +		if (result != VIRTIO_CAN_RESULT_OK)
> > > +			netdev_warn(dev, "TX ACK: Result = %u\n", result);
> > 
> > Maybe an error frame reporting CAN_ERR_CRTL_UNSPEC would be better?
> > 
> I am not sure. In xilinx_can.c, CAN_ERR_CRTL_UNSPEC is indicated during
> a problem in the rx path and this is the tx path. I think the comment
> refers to improving the way the driver informs this error to the user
> but I may be wrong.
> 

Since we have no detail of what went wrong here, I suggested
CAN_ERR_CRTL_UNSPEC as it is "unspecified error", to be coupled with a
controller error with id CAN_ERR_CRTL; however, a different error might be
more appropriate.

For sure, at least in my experience, having a warn printed to kmsg is *not*
enough, as the application sending the message(s) would not be able to detect
the error.


> > For sure, counting the known errors as valid tx_packets and tx_bytes
> > is misleading.
> > 
> 
> I'll remove the counters below.
> 

We don't really know what's wrong here - the packet might have been sent and
and then not ACK'ed, as well as any other error condition (as it happens in the
reference implementation from the original authors [1]). Echoing the packet
only "to bring a waiting process in an upper layer to an end" and incrementing
counters feels wrong, but maybe someone more expert than me can advise better
here.


[1] https://github.com/OpenSynergy/qemu/commit/115540168f92ba5351a20b9c62552782ea1e3e04


Regards,
Francesco




