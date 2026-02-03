Return-Path: <linux-can+bounces-6466-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNjbJgDmgWl0LwMAu9opvQ
	(envelope-from <linux-can+bounces-6466-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 13:11:44 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 140D3D8D6E
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 13:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28F1E30E9A1B
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 12:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6540333E356;
	Tue,  3 Feb 2026 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsJZUKRP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qDL/kEI0"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E5933D6EC
	for <linux-can@vger.kernel.org>; Tue,  3 Feb 2026 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120325; cv=none; b=kvHvDRNUKmh/Oza/0hnS1kPjLuX93YO6VpMVq+PSsoo7mqk+BmkTCd73zEwqCd5Yeo+DebdeVz6yDpkGuaiBFuEdwcDgkDNc0PjlkzfjnX89pEPonBjmFzlrL1TyT2nFGDGSVDQCw9WK1OP/e5YN/fgdcl8Yy94X9CNctlMONMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120325; c=relaxed/simple;
	bh=eoIReSmvJEuRMVBn5J7KvKvNn+HlzBOykWPjPWnhaHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tlem9+Xdzv9I9L6RxYsCmeRJJ8d5C0BpwUO28ut/m5f+57UQqrqLRpi2wUPq3O2l+1DJnworQhdOkl2QllMwm53AQEg0st1C3aAQKmCHsawE4vf1akztpovxASNQ39i5Cd9J0Hv+VSoDYyPfzYkSLfd9/B9HXMF2MelIh5WSHTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EsJZUKRP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qDL/kEI0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770120323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1fWzZQPIc6hPJZu38sl3N1saBNm6B4fuyXwFUKV3TYY=;
	b=EsJZUKRPUf7XoFyv+CUM88xE8SLvyxqGDVkAkEkOC19kWu0+iG0EA/Y4zvHn3kpAinEdEH
	dylSa+A70fEgrbwpMpdpFS413dK9uNzdh6PDc5WvGNO2BUgpUS5VddQptENj6M2D+0Qzvq
	RufLhpM+s6wJHrnkfKu70hnRX8TnME8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-SSeoW2G6MmqBJQICt97DYA-1; Tue, 03 Feb 2026 07:05:21 -0500
X-MC-Unique: SSeoW2G6MmqBJQICt97DYA-1
X-Mimecast-MFC-AGG-ID: SSeoW2G6MmqBJQICt97DYA_1770120321
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-435a6c0c794so4011821f8f.2
        for <linux-can@vger.kernel.org>; Tue, 03 Feb 2026 04:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770120320; x=1770725120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1fWzZQPIc6hPJZu38sl3N1saBNm6B4fuyXwFUKV3TYY=;
        b=qDL/kEI087o2Eh0trJ9MYdoyNF3cTBeo9LSEuAtrxwgd3PMrOXz0uNtPDILU/jiPmt
         wM1bcpWw3b0DJalAWSargWch9D2IN13O7uKezsO8XJosKTF44Xentfb0p8nbznig9DhW
         WDVnK5VhslY8smeBqteg8bbadc0t2PsAN6KGjwzyksFdI65Kcw+s7EudmydaWOYIf6FT
         Sx9xlLsPDWKxENLvzZi5MInTf4rx9pBAP03H4dsX6AqPEKE3v/MsZ0eG6qrFHIbHwp1W
         U1unZUQXvvpLIRPVICG9QZ9vk3n/PJwKJto3VawBXmgrIqlwqTDGp37OK1ecFM1Gb+aW
         aODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770120320; x=1770725120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fWzZQPIc6hPJZu38sl3N1saBNm6B4fuyXwFUKV3TYY=;
        b=gFmVCF7hgQa7vBd60505kR/LHKyP6ZU15ZhrBcD+jW25R6+VUiKxkp1dlN621Wch0g
         +QcdLEx7RVEwPvN8CWlrv899urQxscir6mc0tcHoKugv+y5j1GDEmkAy+I5CA0mjijV2
         Jyqr56TelGiL1P9sZEN5mcURDhPgKeprYR1tgRAid8SnhIDdgkWR2KHaelslN++urYAw
         8HTbtaE8nEx4mjB/j8eKme9pP2Xg9+B49d9riJN0TAKjP0OfAJEHEuqgg2bqz6VflfmN
         KIQFHxW8kvIQlEQOp6yefWpDc0mcPfv+7uKYLsMcs5dQhZdbjj9bG43RdawO27u24eiP
         oKDg==
X-Forwarded-Encrypted: i=1; AJvYcCUT1jTdFcXIDZsJRxd6FAZMLvFAZNt54eEJ+adyIHut16TXygfM12wL8nrO945hDrqSVpNsc5ew1Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweh9/j8xvRH6v6lM2r/tgJW5fYI5sBOqcBfPWVPtXq8evkt0m2
	LcfP3G2cE4mY8D+2HZBdmUALfegA+zcB2nkj3TCUlScp7ruA5JEm0onBBrGF/ucbIhbxa1gmNhi
	nddKNRwyeCOn2SPPbGtp0fFMcmujM9TRlBpCoANSRq2N8ztyux5lMn2KvVtAPSyjriT6VIQ==
X-Gm-Gg: AZuq6aJEDLDEkFNvgafp7FIwJOm/CrOponEwi22ofWARrONt628rYqn8qLmfl4OVmV1
	q0mxNKurt6msTkV/fCJhukbwNeRmwLnmPPaXoAdXQpH4O2pd4kPuMoVj1JOMh5JthoemQ4nEpRb
	Lbt0s8dIK0i26Ls5OY7FNYkTLy/lsvD5/YS/LXdnvbOwW4Jpwp8Z2VWzyxRF1/CqLLK/ou4PSxj
	Cx/bhzZ+EnQhM2GOqPzf9ilK9QlI2BE4ImiWSRHYmYJlzIB04Z5QYsDzwmoNku/4OcHytI7gpiS
	vfr8ww0qiG9EVYomjARitwFmu7yqLmgs4phRfllbela+j2YHAzcf1JA8xVkrIcocil4Lo4fk+l0
	lpYAsvmMiDjKkto22R8mzEAYVwsp/Lc431Q==
X-Received: by 2002:a05:6000:430e:b0:435:dd81:4f4c with SMTP id ffacd0b85a97d-435f3a63167mr22066481f8f.9.1770120320367;
        Tue, 03 Feb 2026 04:05:20 -0800 (PST)
X-Received: by 2002:a05:6000:430e:b0:435:dd81:4f4c with SMTP id ffacd0b85a97d-435f3a63167mr22066421f8f.9.1770120319840;
        Tue, 03 Feb 2026 04:05:19 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1354d43sm55930296f8f.43.2026.02.03.04.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 04:05:18 -0800 (PST)
Date: Tue, 3 Feb 2026 07:05:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Harald Mommer <harald.mommer@oss.qualcomm.com>
Cc: Francesco Valla <francesco@valla.it>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v7] can: virtio: Add virtio CAN driver
Message-ID: <20260203070338-mutt-send-email-mst@kernel.org>
References: <aVwGfOlvRqdv5xj7@fedora>
 <aWE5duyvXCuwsMAn@bywater>
 <eec1a83b-e36f-47bb-9a5b-6888b42e063a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eec1a83b-e36f-47bb-9a5b-6888b42e063a@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6466-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 140D3D8D6E
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 12:55:07PM +0100, Harald Mommer wrote:
> 
> 
> On 1/9/26 18:23, Francesco Valla wrote:
> >> +static u8 virtio_can_send_ctrl_msg(struct net_device *ndev, u16 msg_type)
> >> +{
> >> +	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
> >> +	struct virtio_can_priv *priv = netdev_priv(ndev);
> >> +	struct device *dev = &priv->vdev->dev;
> >> +	struct virtqueue *vq;
> >> +	unsigned int len;
> >> +	int err;
> >> +
> >> +	vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
> > Nit: consider initializing this above, while declaring it.
> 
> All those "Nit" regarding initialization cause problems. There is a reason why it was done the way it is.
> 
> The network people require that the declaration lines are ordered by line length. longest line first. This is called "Reverse Christmas tree". Don't ask me why, this formatting style is what the network people require. Their subsystem, their rules.
> 
> To initialize the vq you need now already the priv initialized. If now the vq line becomes longer than the priv line you will violate the special formatting requirements of the network subsystem.
> 
> Solution was: What you see above.
> 
> Regards
> Harald

So you reorder it then:

	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
	struct virtqueue *vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
	struct virtio_can_priv *priv = netdev_priv(ndev);
	struct device *dev = &priv->vdev->dev;
	unsigned int len;
	int err;


and where is the problem?

On the flip size, this guarantees we will not forget to initialize.


-- 
MST


