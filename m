Return-Path: <linux-can+bounces-5235-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF27BF1F1B
	for <lists+linux-can@lfdr.de>; Mon, 20 Oct 2025 16:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D1F3B0B3B
	for <lists+linux-can@lfdr.de>; Mon, 20 Oct 2025 14:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E43622A80D;
	Mon, 20 Oct 2025 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1GdVrlv"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D08227E95
	for <linux-can@vger.kernel.org>; Mon, 20 Oct 2025 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972181; cv=none; b=Y8F84YLnnD7yAIviPSSz7RXc8G0cT+aagVEHip3V5DyyQOGJ1lktyZEVDmTCMQbWoxa5Fr0AtO0ZW4GYj39fgjj5mgJ8H1RjI5xg+FRa4Mzu8XjUO7S1wpZMyHElBtUU+SpCrrWoGTlJpaR0arNaE9D/rAvC15/9PEx87GvNCDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972181; c=relaxed/simple;
	bh=/HR2FTJi1fhmbceyaoHcX88vfCwNJFFtxcpJPIU9AAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdtUGkEOylDvYlcbUIKRNZDH/BanbRUfbeCI+bB8D6hso2fycoj8D+hxb0M/KD5ZJV9bhZEHhPZTbaH9Y8UHwafefe0id1dkUFm8IY7rJcqkWLb5CQ0yi6lFz0owN+t8nXxv5ttxiHBRvDueOorjAp3YlXRU3Aa47+3nAcb+1qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h1GdVrlv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760972178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1k4CgXl3sl9wN3j76v6ryt7WSQ6sNGhilXai3IXkOjA=;
	b=h1GdVrlvbXm4Ksa47MGapoAtlmZZYIQtZuRasgOOpXJjzEiOvebp45fSXYcaNH7WDC1dep
	MIpZ3GG6twYlcl3rCi8iODYzw3/3wsSsESfsBrjGTzaoA+vCZPhqQ0kgp8iy++2ZuT9CFO
	Qarqd6kQTMFcEwxuwlsMmLokVPkRjpY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-WNZPkFVIOvSZB0XEu8-79g-1; Mon, 20 Oct 2025 10:56:17 -0400
X-MC-Unique: WNZPkFVIOvSZB0XEu8-79g-1
X-Mimecast-MFC-AGG-ID: WNZPkFVIOvSZB0XEu8-79g_1760972176
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-426ff59a320so6120366f8f.3
        for <linux-can@vger.kernel.org>; Mon, 20 Oct 2025 07:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760972176; x=1761576976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1k4CgXl3sl9wN3j76v6ryt7WSQ6sNGhilXai3IXkOjA=;
        b=ZomlCwtiKHxMnRdh/WshGvQqiKV/tBlFNIn9uRvYUFrH6sgK8hy0uTjIMVqmHlxrGL
         JKPzXHPUgkz2lnk90jlKLlWAKh9fGlKFPqoxUYFkwzRNfN7JEFQCt/V7QzbskdWFMae6
         AHvgKJF4GX0BPT0UqWABdrCRX4lghBMfGUWhD2EsYcpYd/PxX7FtVzo8LtzJQ8zvCOpq
         L3Ncv/+r4IhzYQ+mIHOHLXSG963Q4DF2v17P8Cp8DZdDY86wq0od3Okdmzzf1GsnDiUY
         5mQIFC8XI8YR8GEjGbSDT/CMNKELU3ExJHzIegI5/EszFsfyyH1veuB31r4g8ptHA0ZI
         Gwig==
X-Forwarded-Encrypted: i=1; AJvYcCULIGfDrcpREthbHPjLss0JPrrs/sspEq0hywqcA7yXxUJjaGDuw0ILRrw9K+nLQYLbBDA+RGj8Di8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyROF/vucstva+bvchucMFDoScoKLlEVFX4RP+W1BHEyktlP8cj
	i2P8LHAYsS47fCD8ltw5jnNDCq10pECtm4JwW1tB1gvr6johFPe3+xw9DPAU3Od4cYitJoKuujW
	eM+18G9RK34m5/oHt48wfZ+M2z+3T8E9EOopHQMQx3Zm4jquJjnULPu2tQxH2Bw==
X-Gm-Gg: ASbGncubsqqlK7SMUGH2tNfbiP1lnSqMSq8pKs1hQbHYhl3/I+vWHbdZafFQOkAqSzf
	7XPmhwqyx7iYRPr0KBFZIXfBRfcX0npIZwx9usGsTRz1Y9NoK7MZ911BLwsbmekcU4/+cnCOI1U
	q0anJjOkBIAJ9w0JgW9Zq9axXSQIEQbS4e086b5uepax4movnsncJPJaE8pjhjvrkV/hFyr5Mfw
	1AMd1Iji78j7VDhqNg61OciJrkXPhiHYCl9+3Pdnu383ocrCOJiAKlGxJFJ9GTrYoS92AY74H5h
	BD2GnvMzPeWIDMOIASyW6+PEleUPwbpRdlgXilA8kFRNNvURQJT4J96R46GWbfIXVA==
X-Received: by 2002:a05:6000:4021:b0:426:d836:f323 with SMTP id ffacd0b85a97d-42704d7e928mr9224479f8f.13.1760972175820;
        Mon, 20 Oct 2025 07:56:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5sg+KduAEaSO0d/WTabEkdjCGGskJwx7DMn5BIab28WZa40Ixe7cQ3ithEZxOA44qPb92Gw==
X-Received: by 2002:a05:6000:4021:b0:426:d836:f323 with SMTP id ffacd0b85a97d-42704d7e928mr9224439f8f.13.1760972175185;
        Mon, 20 Oct 2025 07:56:15 -0700 (PDT)
Received: from fedora ([212.133.41.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ba070sm15840369f8f.42.2025.10.20.07.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:56:14 -0700 (PDT)
Date: Mon, 20 Oct 2025 16:56:08 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Francesco Valla <francesco@valla.it>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
	Harald Mommer <harald.mommer@opensynergy.com>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	development@redaril.me
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <aPZNiD1SN16K7hmT@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <2243144.yiUUSuA9gR@fedora.fritz.box>
 <aO4isIfRbgKuCvRX@fedora>
 <1997333.7Z3S40VBb9@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1997333.7Z3S40VBb9@fedora.fritz.box>

On Tue, Oct 14, 2025 at 06:01:07PM +0200, Francesco Valla wrote:
> On Tuesday, 14 October 2025 at 12:15:12 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> > > Hello Mikhail, Harald,
> > > 
> > > hoping there will be a v6 of this patch soon, a few comments:
> > > 
> > > On Monday, 8 January 2024 at 14:10:35 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:
> > > 
> > > [...]
> > > > +
> > > > +/* Compare with m_can.c/m_can_echo_tx_event() */
> > > > +static int virtio_can_read_tx_queue(struct virtqueue *vq)
> > > > +{
> > > > +	struct virtio_can_priv *can_priv = vq->vdev->priv;
> > > > +	struct net_device *dev = can_priv->dev;
> > > > +	struct virtio_can_tx *can_tx_msg;
> > > > +	struct net_device_stats *stats;
> > > > +	unsigned long flags;
> > > > +	unsigned int len;
> > > > +	u8 result;
> > > > +
> > > > +	stats = &dev->stats;
> > > > +
> > > > +	/* Protect list and virtio queue operations */
> > > > +	spin_lock_irqsave(&can_priv->tx_lock, flags);
> > > > +
> > > > +	can_tx_msg = virtqueue_get_buf(vq, &len);
> > > > +	if (!can_tx_msg) {
> > > > +		spin_unlock_irqrestore(&can_priv->tx_lock, flags);
> > > > +		return 0; /* No more data */
> > > > +	}
> > > > +
> > > > +	if (unlikely(len < sizeof(struct virtio_can_tx_in))) {
> > > > +		netdev_err(dev, "TX ACK: Device sent no result code\n");
> > > > +		result = VIRTIO_CAN_RESULT_NOT_OK; /* Keep things going */
> > > > +	} else {
> > > > +		result = can_tx_msg->tx_in.result;
> > > > +	}
> > > > +
> > > > +	if (can_priv->can.state < CAN_STATE_BUS_OFF) {
> > > > +		/* Here also frames with result != VIRTIO_CAN_RESULT_OK are
> > > > +		 * echoed. Intentional to bring a waiting process in an upper
> > > > +		 * layer to an end.
> > > > +		 * TODO: Any better means to indicate a problem here?
> > > > +		 */
> > > > +		if (result != VIRTIO_CAN_RESULT_OK)
> > > > +			netdev_warn(dev, "TX ACK: Result = %u\n", result);
> > > 
> > > Maybe an error frame reporting CAN_ERR_CRTL_UNSPEC would be better?
> > > 
> > I am not sure. In xilinx_can.c, CAN_ERR_CRTL_UNSPEC is indicated during
> > a problem in the rx path and this is the tx path. I think the comment
> > refers to improving the way the driver informs this error to the user
> > but I may be wrong.
> > 
> 
> Since we have no detail of what went wrong here, I suggested
> CAN_ERR_CRTL_UNSPEC as it is "unspecified error", to be coupled with a
> controller error with id CAN_ERR_CRTL; however, a different error might be
> more appropriate.
> 
> For sure, at least in my experience, having a warn printed to kmsg is *not*
> enough, as the application sending the message(s) would not be able to detect
> the error.
> 
> 
> > > For sure, counting the known errors as valid tx_packets and tx_bytes
> > > is misleading.
> > > 
> > 
> > I'll remove the counters below.
> > 
> 
> We don't really know what's wrong here - the packet might have been sent and
> and then not ACK'ed, as well as any other error condition (as it happens in the
> reference implementation from the original authors [1]). Echoing the packet
> only "to bring a waiting process in an upper layer to an end" and incrementing
> counters feels wrong, but maybe someone more expert than me can advise better
> here.
> 
> 

I agree. IIUC, in case there has been a problem during transmission, I
should 1) indicate this by injecting a CAN_ERR_CRTL_UNSPEC package with
netif_rx() and 2) use can_free_echo_skb() and increment the tx_error
stats. Is this correct?

Matias


