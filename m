Return-Path: <linux-can+bounces-6467-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMiZA2/sgWkFMAMAu9opvQ
	(envelope-from <linux-can+bounces-6467-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 13:39:11 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79073D91AF
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 13:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EEC130BA54A
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 12:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA34340A57;
	Tue,  3 Feb 2026 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWQ20bs8"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1171C69D
	for <linux-can@vger.kernel.org>; Tue,  3 Feb 2026 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121980; cv=none; b=QNoFkk4ePTAkeY+LBWSghst5I+yz0NTc76ItiLssIvvyNzpXukGFiV9tg0lM23eZ46hq+/gGPCH0XlYAiI/gsd0voIRGEiYrJcpUaga0wDtge6z1tDbvn9XBmBOisv/Ffxd9mIs4Sm5Qo0zyhQWhV9JqjdJNFl9LoYhY2+knqes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121980; c=relaxed/simple;
	bh=aMGJcqEZ69+Re77t7R0d6hzbOIwQePmIuFEaZXaa9d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rb9uxhPgua7+WOTRggTg86whhiHGGYt/Yvma+C/K56isY1BD0Abjtv9SLHICY75gz7lAT6mDJNsclP98pNkUFbyUzwlR34k/QvRzZAIiIxTTUBEO1BmcLQojRFGiD1Vgi8POUzlPyaOg3q7cxMixwjL2Ymv+eUyCFKnjE09JZyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWQ20bs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800C8C2BC87
	for <linux-can@vger.kernel.org>; Tue,  3 Feb 2026 12:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770121980;
	bh=aMGJcqEZ69+Re77t7R0d6hzbOIwQePmIuFEaZXaa9d8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WWQ20bs8IktmiN5Gv4Hbtemqg3ZozWtgUEm2X8BRSvvg8Ft/JZUfNJ9hGjvGXL5Xs
	 Pgjli0PbHG25CluBKUx2QC1Hf1lyy3PdmSHfq4PxuHgfW8QG4jhyn2wm5AhqA5qS8d
	 zDqxpJ02IFWvQrngCP2sQ561sbK4rJkBvo+fnlSY4a5i8rIdtmf1pspEysSo9Cus80
	 d42Y0Be/e+a5a0rGDh7P/5/r8xxQL3sE0+o+oEDF7VFOYZ9uEhK8xX5GB9r4TlE9p/
	 8a2Np9uof9kfmfPWEFWhSt1ZMvmggSepynY6FyCOZXy8mDOLuYBJ/Ueg5Tu3EPk2AX
	 cvRN9syPaU0zg==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b884a84e655so814269866b.0
        for <linux-can@vger.kernel.org>; Tue, 03 Feb 2026 04:33:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX79/eNk5E+7xLE1jQt0DrkPe3VvOr5O+EiojubAq0sNEjBEj3BF818091HSE2Jq7CquOnos8BP4bs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/V+grmWCpkVHLAKFqiYo/WzdWT2az6j+E8V2DRCSpyySNcGcQ
	dzGj2lNSI4f8ZIKeamo1rAqvNXWDDs9icJvwbIIvBHcfj79X1YNlqn3DmnYEaAyYXFYTJ52Ga1S
	3sndx9hbPDk55C4xGj2w46obqhyYqBJE=
X-Received: by 2002:a17:906:6a13:b0:b80:a31:eb08 with SMTP id
 a640c23a62f3a-b8dff839999mr938893766b.55.1770121979181; Tue, 03 Feb 2026
 04:32:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aVwGfOlvRqdv5xj7@fedora> <aWE5duyvXCuwsMAn@bywater>
 <eec1a83b-e36f-47bb-9a5b-6888b42e063a@oss.qualcomm.com> <20260203070338-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260203070338-mutt-send-email-mst@kernel.org>
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 3 Feb 2026 13:32:47 +0100
X-Gmail-Original-Message-ID: <CAMZ6Rq+M2zS=BbOz3x0GPprO+J+yreAbjOAsr=3bjfi9gRvApQ@mail.gmail.com>
X-Gm-Features: AZwV_QhJDubFh7eiXa2IiMs9LIyA1ClgYrjEa3b34iAxU57WJMsJCNWoriceVqE
Message-ID: <CAMZ6Rq+M2zS=BbOz3x0GPprO+J+yreAbjOAsr=3bjfi9gRvApQ@mail.gmail.com>
Subject: Re: [PATCH v7] can: virtio: Add virtio CAN driver
To: "Michael S. Tsirkin" <mst@redhat.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Harald Mommer <harald.mommer@oss.qualcomm.com>, Francesco Valla <francesco@valla.it>, 
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>, 
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org, 
	virtualization@lists.linux.dev, Wolfgang Grandegger <wg@grandegger.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6467-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 79073D91AF
X-Rspamd-Action: no action

On Mar. 3 Feb. 2026 at 13:05, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Feb 03, 2026 at 12:55:07PM +0100, Harald Mommer wrote:
> >
> >
> > On 1/9/26 18:23, Francesco Valla wrote:
> > >> +static u8 virtio_can_send_ctrl_msg(struct net_device *ndev, u16 msg_type)
> > >> +{
> > >> +  struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
> > >> +  struct virtio_can_priv *priv = netdev_priv(ndev);
> > >> +  struct device *dev = &priv->vdev->dev;
> > >> +  struct virtqueue *vq;
> > >> +  unsigned int len;
> > >> +  int err;
> > >> +
> > >> +  vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
> > > Nit: consider initializing this above, while declaring it.
> >
> > All those "Nit" regarding initialization cause problems. There is a reason why it was done the way it is.
> >
> > The network people require that the declaration lines are ordered by line length. longest line first. This is called "Reverse Christmas tree". Don't ask me why, this formatting style is what the network people require. Their subsystem, their rules.

I am fine with the Reverse Christmas Tree in general, except when it
randomly splits the initialization, as is the case here. As you noted,
this is a coding rule of the network subsystem, but here we are the
CAN subsystem. So yes, the CAN is itself a sub-subsystem of network,
but my point is that we are a different team of maintainers. I would
like to ask the network maintainers for understanding regarding our
different preferences on that topic.

Unless Marc or Oliver have a strong opinion on this, I would prefer
not to push the Reverse Christmas Tree to its limits and to allow,
within the CAN subtree, exceptions whenever this would avoid some
hanging initializations.

> > To initialize the vq you need now already the priv initialized. If now the vq line becomes longer than the priv line you will violate the special formatting requirements of the network subsystem.
> >
> > Solution was: What you see above.
> >
> > Regards
> > Harald
>
> So you reorder it then:
>
>         struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
>         struct virtqueue *vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
>         struct virtio_can_priv *priv = netdev_priv(ndev);
>         struct device *dev = &priv->vdev->dev;
>         unsigned int len;
>         int err;
>
>
> and where is the problem?

The problem is that priv is not yet declared. So this:

  struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
  struct virtio_can_priv *priv = netdev_priv(ndev);
  struct virtqueue *vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
  struct device *dev = &priv->vdev->dev;
  unsigned int len;
  int err;

is forced, which, IMHO, is totally *fine* and way better than
deporting down the vq initialization.

> On the flip size, this guarantees we will not forget to initialize.

Yes!


Yours sincerely,
Vincent Mailhol

