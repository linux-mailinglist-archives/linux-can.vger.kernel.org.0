Return-Path: <linux-can+bounces-6468-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA1EDkHvgWlAMwMAu9opvQ
	(envelope-from <linux-can+bounces-6468-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 13:51:13 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A67A7D9594
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 13:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3671302A1BE
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 12:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2A03446B3;
	Tue,  3 Feb 2026 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h59O+V9+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qnTGuaiW"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F89A222599
	for <linux-can@vger.kernel.org>; Tue,  3 Feb 2026 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122998; cv=none; b=uSS2c1tyDmkqWXcy+SKpr48P+9BCkILsEaB5cGYzcRWjOxwx3/EmQrb5/75QBm4BGoWmJ/5bTMHR2THdcZwLccV97ylaQBovw/yhDVjIVwNXVlLn569EAs6Lw2ZqJ1LPlsVnPRa+GXrO1vWR+BHEjmbQbuEf3b3xjvH90805jHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122998; c=relaxed/simple;
	bh=KSD1Z2CStjFRJLyCJ/XVh+aYxA3lCgkBIM4NzbjA+uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6HsZv//vR1S6jTzQYzlYXfbE3CgKOjFh7oGSQidF2313V8eaQHTs0anXHzz3O95jF5b5IxWEkL3HsQO45kv7A7fnuL7q5rQ8TyBXCH7oveXJ3SxFLNMkJGZKRg0g9T8EVqLChJQJWFLGv2Eici4XdcYzSgci7kvot6tlOQxF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h59O+V9+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qnTGuaiW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770122996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UHM9GVbyan5FSeynMvjHxc9PXAtNbBPfKgyu2M/C1a8=;
	b=h59O+V9+XX4T0KRQiakQFPrilDJiSfFsS8PdIJh+VYMclVOAmWGhcSM9ErOhbIebkyLAe3
	iuULd23A+b1hLJ/TdmEGf9lvT3OrJ6qJ3iVbpuryg/beOEYS5NJBUtpZL2kHYiDWRJv5Wz
	Xf3jCqV1NIBg3J6SKiOoc9/Z9umYOAo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-duGD73KcO--QM9JFqCTIwQ-1; Tue, 03 Feb 2026 07:49:55 -0500
X-MC-Unique: duGD73KcO--QM9JFqCTIwQ-1
X-Mimecast-MFC-AGG-ID: duGD73KcO--QM9JFqCTIwQ_1770122994
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4801d21c280so45369625e9.1
        for <linux-can@vger.kernel.org>; Tue, 03 Feb 2026 04:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770122994; x=1770727794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UHM9GVbyan5FSeynMvjHxc9PXAtNbBPfKgyu2M/C1a8=;
        b=qnTGuaiWtjN5gAR4/GLgSZ8AKAf+wsxk2QQ2NCdLTwkNT0uBqCvKAoHaTQ6sol404c
         V7cCdpjDpQ/0sbYLREiphDeT/YJbM8L3YJlvdzE4zRzty45cc7IC+++s0EMa5RrCD6Qd
         XN8Xpy6LaaMMQcCU/tMVFZESDVUk/20Ly+t37A5cM3POeouWJtyQbBl7vwlifhH2MruZ
         CrhfaBOGUz7glCNmlC11c/4E8dCRKtnU0e0M72TWY1nyTKXQrYuoyt6b4Zjs+cIrIl72
         IKOdAHp60ZGnjN7Wk0fZHBUak856Ztoe4+5nPdAhtHwvQWBCs4x8oCVop13hbFFdZF/p
         S0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770122994; x=1770727794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHM9GVbyan5FSeynMvjHxc9PXAtNbBPfKgyu2M/C1a8=;
        b=KNmbxYVcj3Bsq4NOfmj3oJeFKFiZgKzD3xF34469qkJ+zAU7FEi/YFDd4++PwaB5nF
         mUda5yHyAGz1l7Q0r29RH55i4TEIQnXqtWbF7F9aMgl8Eq1vEqMoXrgC7UpzMig/mBgC
         Zu4djiC+3uop0mmSHd+Gn+yO6l0rtzQLyV/3gcMXIFFeez5kijBr9OMI8IrFmTCv/UaB
         qUJiZfIGrcN77MpDmw9LfJbTQdahMgwL7W/Smmt2q0GKQhN6uXfYJm8vEBSWpimwgH39
         LHj+PX/ZL8uHx7CqOJVj9p70I8sJ/KQK1TaSXKhJY+vHSIBIZAx8anXJcGl4CNDVM/lU
         V6cw==
X-Forwarded-Encrypted: i=1; AJvYcCUbwRgq3xTGajhSqpWOhCUxEcTdmaVfUjdPr++KuYbjguttG/C5hcOZZc45ISBgf6ZKZTHLd/8cHv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvctZZJPhwOAHhsQ7cETRFEzQnX2EmOtuUIDuyGZPhmaMDUmwx
	ALmemr54HdptmROAa+yev789JRHRjnuMVqrx2ifSr06Fc8uuyLW6nuZM5/hTW01tjSAXnhjlq+7
	udT/p/maI8J1YFcJ3PF0Z0EOTN1CzTX1uCj7I7PjgnagkZW7eJ+zgJ4BXl1IgzA==
X-Gm-Gg: AZuq6aIOoThl17/Cehr3ZvSBTGKMzUotAUhpyv5+5ny5s3yY2tKMa+BZBJR7SoSJHcc
	8o9y1ZywVvPBJb+VtepFPh59bAxc3v1lpsWuOLBI/S8I6I+csaggNma7X5g7Z0ILdLFpxzc15xI
	WBwxbsFVmGBtOO0SCUosjkw/ZgCwFFgXAuenht24KTZTU7AkhbOyhPqVBHF5AmDaawTAcXweJrR
	HT/UySDJuBwuWJxP6MmjGelgn/Z1GDCRZh/RIujje4ltF+HuSTluwRND5IAGY3ZmOPckxqTXJ+E
	ADwIr3x7GPz9163wR1O53rmeVfnJ649fBWrrNmsQKNpQ3zVgM8lDeXDtsBs84mWEG3OSJ4/di8W
	UcJSDrWJ6wY/d5tn2NUiVEioNkVWZwlxkYQ==
X-Received: by 2002:a05:600c:8b61:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-482db4567cbmr216620435e9.7.1770122993940;
        Tue, 03 Feb 2026 04:49:53 -0800 (PST)
X-Received: by 2002:a05:600c:8b61:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-482db4567cbmr216620065e9.7.1770122993437;
        Tue, 03 Feb 2026 04:49:53 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830511cc93sm72291945e9.2.2026.02.03.04.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 04:49:52 -0800 (PST)
Date: Tue, 3 Feb 2026 07:49:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Francesco Valla <francesco@valla.it>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
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
Message-ID: <20260203074916-mutt-send-email-mst@kernel.org>
References: <aVwGfOlvRqdv5xj7@fedora>
 <aWE5duyvXCuwsMAn@bywater>
 <eec1a83b-e36f-47bb-9a5b-6888b42e063a@oss.qualcomm.com>
 <20260203070338-mutt-send-email-mst@kernel.org>
 <CAMZ6Rq+M2zS=BbOz3x0GPprO+J+yreAbjOAsr=3bjfi9gRvApQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+M2zS=BbOz3x0GPprO+J+yreAbjOAsr=3bjfi9gRvApQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6468-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A67A7D9594
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 01:32:47PM +0100, Vincent Mailhol wrote:
> On Mar. 3 Feb. 2026 at 13:05, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Tue, Feb 03, 2026 at 12:55:07PM +0100, Harald Mommer wrote:
> > >
> > >
> > > On 1/9/26 18:23, Francesco Valla wrote:
> > > >> +static u8 virtio_can_send_ctrl_msg(struct net_device *ndev, u16 msg_type)
> > > >> +{
> > > >> +  struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
> > > >> +  struct virtio_can_priv *priv = netdev_priv(ndev);
> > > >> +  struct device *dev = &priv->vdev->dev;
> > > >> +  struct virtqueue *vq;
> > > >> +  unsigned int len;
> > > >> +  int err;
> > > >> +
> > > >> +  vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
> > > > Nit: consider initializing this above, while declaring it.
> > >
> > > All those "Nit" regarding initialization cause problems. There is a reason why it was done the way it is.
> > >
> > > The network people require that the declaration lines are ordered by line length. longest line first. This is called "Reverse Christmas tree". Don't ask me why, this formatting style is what the network people require. Their subsystem, their rules.
> 
> I am fine with the Reverse Christmas Tree in general, except when it
> randomly splits the initialization, as is the case here. As you noted,
> this is a coding rule of the network subsystem, but here we are the
> CAN subsystem. So yes, the CAN is itself a sub-subsystem of network,
> but my point is that we are a different team of maintainers. I would
> like to ask the network maintainers for understanding regarding our
> different preferences on that topic.
> 
> Unless Marc or Oliver have a strong opinion on this, I would prefer
> not to push the Reverse Christmas Tree to its limits and to allow,
> within the CAN subtree, exceptions whenever this would avoid some
> hanging initializations.
> 
> > > To initialize the vq you need now already the priv initialized. If now the vq line becomes longer than the priv line you will violate the special formatting requirements of the network subsystem.
> > >
> > > Solution was: What you see above.
> > >
> > > Regards
> > > Harald
> >
> > So you reorder it then:
> >
> >         struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
> >         struct virtqueue *vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
> >         struct virtio_can_priv *priv = netdev_priv(ndev);
> >         struct device *dev = &priv->vdev->dev;
> >         unsigned int len;
> >         int err;
> >
> >
> > and where is the problem?
> 
> The problem is that priv is not yet declared. So this:
> 
>   struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
>   struct virtio_can_priv *priv = netdev_priv(ndev);
>   struct virtqueue *vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
>   struct device *dev = &priv->vdev->dev;
>   unsigned int len;
>   int err;
> 
> is forced,

Ah. Good point.

> which, IMHO, is totally *fine* and way better than
> deporting down the vq initialization.

Indeed.


> > On the flip size, this guarantees we will not forget to initialize.
> 
> Yes!
> 
> 
> Yours sincerely,
> Vincent Mailhol


