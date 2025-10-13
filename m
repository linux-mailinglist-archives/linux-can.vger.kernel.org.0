Return-Path: <linux-can+bounces-5169-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1793ABD37FE
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 16:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D436C4F1DF7
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F7F308F26;
	Mon, 13 Oct 2025 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxvJ9B5+"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C37430E0D3
	for <linux-can@vger.kernel.org>; Mon, 13 Oct 2025 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364948; cv=none; b=VwBXftsHIv0kRlUGLYon18XB4mRU8xQN0S22t4pjekArOjsWj6HZGurrCJdgbtddrI27H1gHJb9eJp/RnjEdDTnJBUbFtyQNGtxgdj5gsprPwFDpjKn71tR9zcfv9poBBDbe+2DAyuCvwzNo2DUqIqsPN3VlBpzUYwpgrrnl4U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364948; c=relaxed/simple;
	bh=X6/q1bHsLK+ZhgGEzfdnTYkllaQ39VA9H94eFOB9hyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ep8/iGJVckgOaqSAa704p/NKaQsPkU6NQOOlO1cqci9diYNf2ITSACUvqEKbGDe5VX2rw9gbjr44IsOoanrtr/Op8d4LoNZsH4ZeW0j8wRsIRNEdZSVBM4oWeuAf96CZQ4EYnJJLYBkHI0U5aQjh+d5yinbYixAQfTNEf/8ob44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxvJ9B5+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760364945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9uIgQtAlSBtKcFSO9NiV0X395eAsPo0/3pZRzpykst8=;
	b=OxvJ9B5+Ov0+JYuUbY/CpHKdEMN8k9UsUM/YcDt+ySUsd//bH/N+I23vdQmxQPitI2GkdM
	6rLS0m44nKF2PFpiHdY9wM8mXdrCEqqpTgZCrq+m0igJmHAkn94ZIOATPfRn8Z+HdV9pBU
	QBvUt5nU8mDSsb6+enDMKP2R6ktuFeY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-NegxUsOuP6a4X3rFOTolFQ-1; Mon, 13 Oct 2025 10:15:44 -0400
X-MC-Unique: NegxUsOuP6a4X3rFOTolFQ-1
X-Mimecast-MFC-AGG-ID: NegxUsOuP6a4X3rFOTolFQ_1760364943
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso39068075e9.2
        for <linux-can@vger.kernel.org>; Mon, 13 Oct 2025 07:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760364943; x=1760969743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uIgQtAlSBtKcFSO9NiV0X395eAsPo0/3pZRzpykst8=;
        b=OtLqtZM8fhBYTU9I498V/awxIjHodp2SniBVHhDWvQqTeqYIvmCerM4i7l9Vy7ue4v
         vPhLpkoSN2EeH75FacKBPI4+fyNhrZy//n+Q8oj6UD4bRdbqk7TkakF/puZfRdEWC+5E
         Ss38vmpeiRwJBwBJx7W7/cc28gCWAFGMdZxfd7iwx7wJsUxWLAE+eFh6yRc9KjUitJUE
         HuG9NWmTFLaKJ31OW+3CC7CLALEnMvBF4eM9AW6iwyMzMb+usM0S4bN++MRnY6Dhxiob
         DbQDhJiklm4WgKlPVv054taGpLPja3jinX1Dp6+/6z2IDQ208/uXJcmJRhb9sd9McWI5
         tJJA==
X-Forwarded-Encrypted: i=1; AJvYcCXMHzN/MkVD6/Q6mVOuOU28d/ZarCaHMq0pn0e6L1vIE540VIisLsiLdEj/4cmlnxv0jmOssxrKNRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP9DnTODv59pTw2vyiXSifGxQj5oCgeWVounHmVvkf3c0/fxan
	D/swHbxgjdYjyd8o4eKo/RVOw0Js6AUclt4YiCHkpNnUvoawTFV8I02OF0b7hE0Gx1Ym61o0L1b
	aq7cbQX9DFSUSGygGVPYwtfguh2mPAsYBrfPzgMz0HfRKxOD6pnOvIyMCP0fzbA==
X-Gm-Gg: ASbGncsrMrm72BlK6Vc/wHl6+PTgBReuR9WOPT7itfiiuBnvxBy/OgwmAH8ko3JdyXI
	R1BPwOi2dgQ6mcNRV5GARFWmkaAdoLkTlAzBFm+tnyUr/BMYmMC7c+huXcDgF+fyHJ3HB/kEBxv
	KJgvvym06JMa9opqch9mj8yGoGA4lxoMGwTTjFoYeuSfOjuyEu5LgsKx0Tkkkv4hH7g2RjQPikJ
	fVHRnGvc7/Rpv37HW1ufkYez9Ft7uH3BLvlItGkkHUqtR2u2Vg685uvFT4BRKISX0RUdMm1ahXm
	sjTG0m4Hkcii1ZmGhMdvkn+zM1V/y6pYqA==
X-Received: by 2002:a05:600c:502c:b0:46e:3d41:5fe6 with SMTP id 5b1f17b1804b1-46fa9a9ebb8mr139543415e9.9.1760364942891;
        Mon, 13 Oct 2025 07:15:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR9AfQG1bPxhSVGiAWctJCWR2+PTWw1bYga2tLxdTe6Ieug+DROBY5xi12o8AGOXPV/OiFfQ==
X-Received: by 2002:a05:600c:502c:b0:46e:3d41:5fe6 with SMTP id 5b1f17b1804b1-46fa9a9ebb8mr139543115e9.9.1760364942471;
        Mon, 13 Oct 2025 07:15:42 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3e3520sm136542145e9.2.2025.10.13.07.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:15:41 -0700 (PDT)
Date: Mon, 13 Oct 2025 16:15:40 +0200
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
Message-ID: <aO0JjDGk2zLlzB1E@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <2243144.yiUUSuA9gR@fedora.fritz.box>
 <aOkqUWxiRDlm0Jzi@fedora>
 <2318164.vFx2qVVIhK@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2318164.vFx2qVVIhK@fedora.fritz.box>

On Fri, Oct 10, 2025 at 11:20:22PM +0200, Francesco Valla wrote:
> On Friday, 10 October 2025 at 17:46:25 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> > > Hello Mikhail, Harald,
> > > 
> > > hoping there will be a v6 of this patch soon, a few comments:
> > > 
> > 
> > I am working on the v6 by addressing the comments in this thread.
> > 
> > > On Monday, 8 January 2024 at 14:10:35 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:
> > > 
> > > [...]
> > > 
> > > > +
> > > > +/* virtio_can private data structure */
> > > > +struct virtio_can_priv {
> > > > +	struct can_priv can;	/* must be the first member */
> > > > +	/* NAPI for RX messages */
> > > > +	struct napi_struct napi;
> > > > +	/* NAPI for TX messages */
> > > > +	struct napi_struct napi_tx;
> > > > +	/* The network device we're associated with */
> > > > +	struct net_device *dev;
> > > > +	/* The virtio device we're associated with */
> > > > +	struct virtio_device *vdev;
> > > > +	/* The virtqueues */
> > > > +	struct virtqueue *vqs[VIRTIO_CAN_QUEUE_COUNT];
> > > > +	/* I/O callback function pointers for the virtqueues */
> > > > +	vq_callback_t *io_callbacks[VIRTIO_CAN_QUEUE_COUNT];
> > > > +	/* Lock for TX operations */
> > > > +	spinlock_t tx_lock;
> > > > +	/* Control queue lock. Defensive programming, may be not needed */
> > > > +	struct mutex ctrl_lock;
> > > > +	/* Wait for control queue processing without polling */
> > > > +	struct completion ctrl_done;
> > > > +	/* List of virtio CAN TX message */
> > > > +	struct list_head tx_list;
> > > > +	/* Array of receive queue messages */
> > > > +	struct virtio_can_rx rpkt[128];
> > > 
> > > This array should probably be allocated dynamically at probe - maybe
> > > using a module parameter instead of a hardcoded value as length? 
> > > 
> > 
> > If I allocate this array in probe(), I would not know sdu[] in advance
> > if I defined it as a flexible array. That made me wonder: can sdu[] be
> > defined as flexible array for rx? 
> > 
> > Thanks.
> > 
> 
> One thing that can be done is to define struct virtio_can_rx as:
> 
> struct virtio_can_rx {
> #define VIRTIO_CAN_RX                   0x0101
> 	__le16 msg_type;
> 	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
> 	__u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
> 	__u8 padding;
> 	__le16 reserved_xl_priority; /* May be needed for CAN XL priority */
> 	__le32 flags;
> 	__le32 can_id;
> 	__u8 sdu[] __counted_by(length);
> };
> 
> and then allocate the rpkt[] array using the maximum length for SDU:
> 
> priv->rpkt = kcalloc(num_rx_buffers,
> 		sizeof(struct virtio_can_rx) + VIRTIO_CAN_MAX_DLEN,
> 		GFP_KERNEL);
> 
> In this way, the size of each member of rpkt[] is known and is thus
> suitable for virtio_can_populate_vqs().
> 
> 

From the spec, VIRTIO_CAN_MAX_DLEN shall be 2048 bytes that corresponds
with CAN-XL frame.

Matias


