Return-Path: <linux-can+bounces-267-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC568533EB
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 16:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 116F8B267E8
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 15:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7889E5F467;
	Tue, 13 Feb 2024 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ciEAhbt+"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D3D5EE88
	for <linux-can@vger.kernel.org>; Tue, 13 Feb 2024 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836285; cv=none; b=QxhrUiJHFRmkOLcmodOJG6tfMHdklwcdC/+hjf4sz5+8bIKv0WO2xMT3rlw5eI1/p4VbEn6zJJr7yQwdxA5pkZdEGM2XcfqzkFhwa2erxS7S7HWV+Ho1JWXWvwwsw/UhQu1fZ/3gR8Xj3SPnbCG2qR5HbLZ7Qs5OOx1zs5WFoL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836285; c=relaxed/simple;
	bh=3Vxpq0HDuZycxM83GFgXuiFeSPMypiZlRi1dKbIPmRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jvj5+LNAgYEiEnS0Y8KlNL2OFCMJLwGjSMeDDU0H2TGLciKZWTl66uktzkEpnnUaH1TnXkh+dKWTEIIlmlF1Zp6kLxbY2EnIBv4c5Bv4N/27rYVXvv2tUolLOCSk1ct9M9oM7uo0nyibzfSaTaG+enA8yPcrdKNEjDmPqZF3QL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ciEAhbt+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707836282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0jVz63E0Ra5aV/3h4Bfsacqtvq+rryvkCmlMhq9CzMU=;
	b=ciEAhbt+5ZNLtI4OWSPiTpWauj4jcD7jvCvLozfN2A5ZNkYdwTKwuiwRB6t6YZsUNhkDlF
	RBGJJ668hMqXAnbuT0fLSU2At9131T4QNgGYyqpRrBOBkUK4QY17iqKoN+MqbTwDqI5gBG
	ruNzQhftGyJvuURBTBhYIsQDKugTDZo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-THNjI6P7PUyHP4SwJWCnVg-1; Tue, 13 Feb 2024 09:58:00 -0500
X-MC-Unique: THNjI6P7PUyHP4SwJWCnVg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 591CD10B02A5;
	Tue, 13 Feb 2024 14:58:00 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1822040C9444;
	Tue, 13 Feb 2024 14:57:59 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 linux-can@vger.kernel.org
Cc: Harald Mommer <harald.mommer@opensynergy.com>, Mikhail Golubev-Ciuchea
 <Mikhail.Golubev-Ciuchea@opensynergy.com>
Subject: Re: [virtio-dev] [RFC PATCH v3] virtio-can: Device specification.
In-Reply-To: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 13 Feb 2024 15:57:59 +0100
Message-ID: <877cj8h0nc.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Fri, Jun 09 2023, Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:

> diff --git a/introduction.tex b/introduction.tex
> index b7155bf..d560c63 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -101,6 +101,8 @@ \section{Normative References}\label{sec:Normative References}
>  	\phantomsection\label{intro:SEC1}\textbf{[SEC1]} &
>      Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic Cureve Cryptography'', Version 1.0, September 2000.
>  	\newline\url{https://www.secg.org/sec1-v2.pdf}\\
> +	\phantomsection\label{intro:CAN}\textbf{[CAN]} &
> +    ISO 11898-1:2015 Road vehicles -- Controller area network (CAN) -- Part 1: Data link layer and physical signalling\\

Just noticed while massaging this patch to apply on top of the 1.4
branch: This reference does not include an url; I guess
https://www.iso.org/standard/63648.html would be the place to point to?

(This can easily be added via an editorial update on top.)


