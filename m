Return-Path: <linux-can+bounces-5246-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B25BF6640
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 14:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE01C545E5F
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 12:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73295333456;
	Tue, 21 Oct 2025 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="dsutjZ5p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="TM1wM7Xl"
X-Original-To: linux-can@vger.kernel.org
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE2F333436;
	Tue, 21 Oct 2025 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048554; cv=pass; b=H594goKpEL6PAcf44K/rw1mU2mfGCdsGV7gYCtKjpbGkYQxaL5t7K2rNGm0PAkXbo53OCqu1lI3LkNqTwPAOiIVH+PEMDifH2cZ0ZH9x5Z/lQTfuxOejyPvl9p/M4iEMIzxfAuXcm5LQ8OWmeBOPOSPF4Ytp9z3osDC6ALB3buk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048554; c=relaxed/simple;
	bh=k/JBKH2vI1/UCFnQkOHqpD/NJyrEHN8KXki2dB6QmkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RV9vxQW6bOYQoLWtnoJKhJlTBDNV80v5tgi3OHeY9jh7Og8WZwOSbwlOVx9+ivUphqdWxAn+7bTVomdG0L8JNiUM5BrlarE5VNUahG4F8ULOfeSWK6EuJ5gF4dnrWw6FsLuoYxPVI9fZqZIZPK/9hlz6/o4d91vdn/CjuZ6KbFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=dsutjZ5p; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=TM1wM7Xl; arc=pass smtp.client-ip=185.56.87.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-zj18.prod.antispam.mailspamprotection.com; s=arckey; t=1761048551;
	 b=T+COwp8whd8ZSF0NdtVGv+GlhR4Q/5wF1a0RPSvET4g3jFz2ZV0bQTT20Au/cwl1eO7YciKgHc
	  2w3egl9jDuh7w9sVJ0Eo0PrGjgC912TMN7RSzq8OyLDDXt4FOA0DFBLpBJrFxOUXo6ZYSvw0qI
	  Y2vj4JpMnDZDJQ+pGm+GVWemwzSvtSIuMNzNoTZccMer2jtiQwibVESx4dt0Uly8REBV/wH3g5
	  wiGLjFF08Xlx3Bw+Zwterx27Lav6bn4Vl5OL2QI90boPsD72+rVngs4sZRlybA8QWBqxlqPWTI
	  IAa5uVmX15//YinJB2k6qzFZy+6KfY4iAg2Jv08AcMSLMQ==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-zj18.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-zj18.prod.antispam.mailspamprotection.com; s=arckey; t=1761048551;
	bh=k/JBKH2vI1/UCFnQkOHqpD/NJyrEHN8KXki2dB6QmkE=;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	  Message-ID:Date:Subject:Cc:To:From:DKIM-Signature:DKIM-Signature;
	b=e0P6G2aWgLGJiiiq7URV8ivG4A3926QuDnBhwRJXhBMn2N0symfJX0+4j6BZzbaUjza7PqPeSL
	  auYGtIa/RuT5QOaXQSzUIPDxFXC/ekmNQj0RTzMJB+Z3W/nNYMIp6dBAEJnqkZM9k0/Vec8Jno
	  zxZG3EzpvANJ+jgjhinC2lGTmxNEvGkqP6fUceBmM9dpgniiocw2fUQEZaKPFg0pLBlVhibRAr
	  jCOX43RCIa6+/keVe9hI2HT+I0hBD6FX5sQc3/zoLUzwNx98VAmk2EtHU5/HertVQ1itDZn4nt
	  eWiRou6QKNHS8e3MUpHmwgtMjrySmaAQYR4BS5HK3Edsqg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Reply-To:List-Unsubscribe;
	bh=pNzAWqaeaTCPO3gF7PZWEYVRaidTc0Ewfr2jBPVAsgE=; b=dsutjZ5pQKCPBe0PrEnlvroEXH
	FtXrz3VPbW4fhrtFFg8Ic4Ln5ozJjr/SdYjEX0z/J8vAAtBEPuj/SHCEYA1pqsQ7E6Ew2tekqJF8s
	CPHzDzjUnFyyZJMK39yvnSQIbIehqlQz6lCZtUQQNmfJX59OHtcEorOdneTlwaWqwXYU=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-zj18.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vBBAg-00000002Bjj-3vVH;
	Tue, 21 Oct 2025 12:09:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=pNzAWqaeaTCPO3gF7PZWEYVRaidTc0Ewfr2jBPVAsgE=; b=TM1wM7XlESEhidmw9p+vMbQbvs
	FYpcCmLo+5qjG832TYone0TFwBdK5DrshS12VcVTmwDb7vr+CS3buAlpwx45LkuVncbpEpqDSkM06
	RcZAqmW6nWEmpK0CZIGXvZRuRYrP1MIn3c6wwf+jTjuBsXHiQGZNR8ijwJubwG8k6So4=;
Received: from [95.239.58.48] (port=60828 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vBBAL-00000000J0Y-1zlx;
	Tue, 21 Oct 2025 12:08:37 +0000
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
Date: Tue, 21 Oct 2025 14:08:35 +0200
Message-ID: <28156189.1r3eYUQgxm@fedora.fritz.box>
In-Reply-To: <aPdU93e2RQy5MHQr@fedora>
References:
 <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <27327622.1r3eYUQgxm@fedora.fritz.box> <aPdU93e2RQy5MHQr@fedora>
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
X-SGantispam-id: 9909174f231b3c6b9b19d237f31e977e
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vBBAg-00000002Bjj-3vVH-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-zj18.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Tuesday, 21 October 2025 at 11:40:07 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> On Mon, Oct 20, 2025 at 11:24:15PM +0200, Francesco Valla wrote:
> > On Monday, 20 October 2025 at 16:56:08 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > > On Tue, Oct 14, 2025 at 06:01:07PM +0200, Francesco Valla wrote:
> > > > On Tuesday, 14 October 2025 at 12:15:12 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > > > > On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> > > > > > Hello Mikhail, Harald,
> > > > > > 
> > > > > > hoping there will be a v6 of this patch soon, a few comments:
> > > > > > 
> > > > > > On Monday, 8 January 2024 at 14:10:35 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:
> > > > > > 
> > > > > > [...]
> > > > > > > +
> > > > > > > +/* Compare with m_can.c/m_can_echo_tx_event() */
> > > > > > > +static int virtio_can_read_tx_queue(struct virtqueue *vq)
> > > > > > > +{
> > > > > > > +	struct virtio_can_priv *can_priv = vq->vdev->priv;
> > > > > > > +	struct net_device *dev = can_priv->dev;
> > > > > > > +	struct virtio_can_tx *can_tx_msg;
> > > > > > > +	struct net_device_stats *stats;
> > > > > > > +	unsigned long flags;
> > > > > > > +	unsigned int len;
> > > > > > > +	u8 result;
> > > > > > > +
> > > > > > > +	stats = &dev->stats;
> > > > > > > +
> > > > > > > +	/* Protect list and virtio queue operations */
> > > > > > > +	spin_lock_irqsave(&can_priv->tx_lock, flags);
> > > > > > > +
> > > > > > > +	can_tx_msg = virtqueue_get_buf(vq, &len);
> > > > > > > +	if (!can_tx_msg) {
> > > > > > > +		spin_unlock_irqrestore(&can_priv->tx_lock, flags);
> > > > > > > +		return 0; /* No more data */
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	if (unlikely(len < sizeof(struct virtio_can_tx_in))) {
> > > > > > > +		netdev_err(dev, "TX ACK: Device sent no result code\n");
> > > > > > > +		result = VIRTIO_CAN_RESULT_NOT_OK; /* Keep things going */
> > > > > > > +	} else {
> > > > > > > +		result = can_tx_msg->tx_in.result;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	if (can_priv->can.state < CAN_STATE_BUS_OFF) {
> > > > > > > +		/* Here also frames with result != VIRTIO_CAN_RESULT_OK are
> > > > > > > +		 * echoed. Intentional to bring a waiting process in an upper
> > > > > > > +		 * layer to an end.
> > > > > > > +		 * TODO: Any better means to indicate a problem here?
> > > > > > > +		 */
> > > > > > > +		if (result != VIRTIO_CAN_RESULT_OK)
> > > > > > > +			netdev_warn(dev, "TX ACK: Result = %u\n", result);
> > > > > > 
> > > > > > Maybe an error frame reporting CAN_ERR_CRTL_UNSPEC would be better?
> > > > > > 
> > > > > I am not sure. In xilinx_can.c, CAN_ERR_CRTL_UNSPEC is indicated during
> > > > > a problem in the rx path and this is the tx path. I think the comment
> > > > > refers to improving the way the driver informs this error to the user
> > > > > but I may be wrong.
> > > > > 
> > > > 
> > > > Since we have no detail of what went wrong here, I suggested
> > > > CAN_ERR_CRTL_UNSPEC as it is "unspecified error", to be coupled with a
> > > > controller error with id CAN_ERR_CRTL; however, a different error might be
> > > > more appropriate.
> > > > 
> > > > For sure, at least in my experience, having a warn printed to kmsg is *not*
> > > > enough, as the application sending the message(s) would not be able to detect
> > > > the error.
> > > > 
> > > > 
> > > > > > For sure, counting the known errors as valid tx_packets and tx_bytes
> > > > > > is misleading.
> > > > > > 
> > > > > 
> > > > > I'll remove the counters below.
> > > > > 
> > > > 
> > > > We don't really know what's wrong here - the packet might have been sent and
> > > > and then not ACK'ed, as well as any other error condition (as it happens in the
> > > > reference implementation from the original authors [1]). Echoing the packet
> > > > only "to bring a waiting process in an upper layer to an end" and incrementing
> > > > counters feels wrong, but maybe someone more expert than me can advise better
> > > > here.
> > > > 
> > > > 
> > > 
> > > I agree. IIUC, in case there has been a problem during transmission, I
> > > should 1) indicate this by injecting a CAN_ERR_CRTL_UNSPEC package with
> > > netif_rx() and 2) use can_free_echo_skb() and increment the tx_error
> > > stats. Is this correct?
> > > 
> > > Matias
> > > 
> > > 
> > 
> > That's my understanding too! stats->tx_dropped should be the right value to
> > increment (see for example [1]).
> > 
> > [1] https://elixir.bootlin.com/linux/v6.17.3/source/drivers/net/can/ctucanfd/ctucanfd_base.c#L1035
> > 
> 
> I think the counter to increment would be stats->tx_errors in this case ...
> 

I don't fully agree. tx_errors is for CAN frames that got transmitted but then
lead to an error (e.g.: no ACK), while here we might be dealing with frames
that didn't even manage to reach the transmission queue [1].

An exception to this may arise when the VIRTIO_CAN_F_CAN_LATE_TX_ACK feature
is negotiated; in this case, a VIRTIO_CAN_RESULT_NOT_OK may indicate either a
dropped frame (tx_dropped) or a failed transmission (tx_error) [2].



[1] https://github.com/oasis-tcs/virtio-spec/blob/master/device-types/can/description.tex#L139 
[2] https://github.com/oasis-tcs/virtio-spec/blob/master/device-types/can/description.tex#L196


BR,
Francesco





