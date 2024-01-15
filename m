Return-Path: <linux-can+bounces-134-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC19982DD86
	for <lists+linux-can@lfdr.de>; Mon, 15 Jan 2024 17:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2321C21E15
	for <lists+linux-can@lfdr.de>; Mon, 15 Jan 2024 16:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDA317BA5;
	Mon, 15 Jan 2024 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKMj3L5s"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808D517BA4
	for <linux-can@vger.kernel.org>; Mon, 15 Jan 2024 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705335852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iPv2FJdHf5QCnJR78ZfSP48UcTqCDAPVi5cmeaqeGn0=;
	b=XKMj3L5ssYm06qvky8uWnWuZp04r4dXR3QoSTQlb8gIV2YnkK5zw4bfLBcXrrjUS8R2RbC
	OxAr021poaOfVuHNpsZ0lNeA+n4PvoWW4HsMFF5lgw5QWwxwVFuDRBebZHdoLDeNaqBwnl
	knHLymHACAe3iRrn55nUzB5KE+GRNDc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-CRzyXD53MPKBXXc5m8IqzA-1; Mon,
 15 Jan 2024 11:24:10 -0500
X-MC-Unique: CRzyXD53MPKBXXc5m8IqzA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8C061C04B5F;
	Mon, 15 Jan 2024 16:24:09 +0000 (UTC)
Received: from localhost (unknown [10.22.8.70])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A0348C19060;
	Mon, 15 Jan 2024 16:24:09 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@opensynergy.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 linux-can@vger.kernel.org
Cc: Harald Mommer <harald.mommer@opensynergy.com>
Subject: Re: [virtio-comment] [RFC PATCH v3] virtio-can: Device specification.
In-Reply-To: <ebc57e36-d822-4264-a763-b530482b2669@opensynergy.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <ebc57e36-d822-4264-a763-b530482b2669@opensynergy.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 15 Jan 2024 17:24:08 +0100
Message-ID: <87ttnemuon.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Mon, Jan 08 2024, Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@opensynergy.com> wrote:

> Hi all!
>
> I kindly request a vote.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/186

Oh, that has been a while... I believe that this still fits on top,
although it has conflicts with virtio-spi, but nothing that a bit of
fiddling can't sort out.

The main problem is that we're currently in a bit of an unfortunate
situation regarding voting: There's still a twice-postponed migration of
the OASIS infrastructure coming up, and I don't want to risk the voting
period being affected by an outage... hopefully we'll get a new schedule
soon.

In the meanwhile, if anyone could spare a few cycles looking at this,
it'd be appreciated. Nothing jumped out at me, but I'm not a CAN expert;
I'd be happy to open voting but for the looming migration issue.


