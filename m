Return-Path: <linux-can+bounces-347-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D986E86751C
	for <lists+linux-can@lfdr.de>; Mon, 26 Feb 2024 13:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166C11C22999
	for <lists+linux-can@lfdr.de>; Mon, 26 Feb 2024 12:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F897EEE6;
	Mon, 26 Feb 2024 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XdUpKnvg"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE235B1F6
	for <linux-can@vger.kernel.org>; Mon, 26 Feb 2024 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951008; cv=none; b=u72oiVIP9SA/C7qs4jeAq+xVpnjBklr1lRgElwJNPDyvPNe0yi7pb5zuNI9MR0OyKNUBEw19MlhoBScPr4LCGa63ps3i6BCeQSw/YCXukaRM0nU53HCwxqUQLRRP8voUgYQif1eoLnULJnChlJxSkq2n+oTXgln4LmgqbRu+COg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951008; c=relaxed/simple;
	bh=KF9mWdl4GqnXZpEmdyaUaQle/tkQUyojq84HaBiLezw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZDw4hVBTzqvYCl4gBL7i5oGem40ikA/+pLF2iNrLxHg/PS/Nah6qbFnErWZRH4/SnJ7WbO4yqD43wjnNwEuBT8FF7nqT5l4Ibo4NkQVELeDfY7a96uFmte+YEicLKzWjye3SYc8tqKU7GTExemnUqh/28oRMHa9sjMZrxRfFUn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XdUpKnvg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708951005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vSvkJaRDkea5JXGa2mNuRJ2No3iF7W8cTe82Q2hjJmE=;
	b=XdUpKnvgeh48NO3TTIofiIn/rqVqw1qg0ErA/4PsPTbsc9FqPALzqbF2NWDn3Gi8LxlhB0
	jAbFrm8SC3VDF65Xst4o4satjr2SR2hAsCn16p/TnTX/BCKV6MoPuE4OdNj8ShKaKrkB4X
	4UJw+fc90Ck/dtL+C78A7HvSgFRfIgA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-vpmPKEoUP32DJ8JW_UvdYQ-1; Mon, 26 Feb 2024 07:36:42 -0500
X-MC-Unique: vpmPKEoUP32DJ8JW_UvdYQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CCDF848525;
	Mon, 26 Feb 2024 12:36:41 +0000 (UTC)
Received: from localhost (unknown [10.22.32.39])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DDB1492BE2;
	Mon, 26 Feb 2024 12:36:41 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Matias Ezequiel Vara Larsen
 <mvaralar@redhat.com>
Cc: Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@opensynergy.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 linux-can@vger.kernel.org, Harald Mommer <harald.mommer@opensynergy.com>
Subject: Re: [virtio-dev] Re: [virtio-comment] [RFC PATCH v3] virtio-can:
 Device specification.
In-Reply-To: <20240221-juggling-uproar-9518b4901f41-mkl@pengutronix.de>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <ebc57e36-d822-4264-a763-b530482b2669@opensynergy.com>
 <ZdXShopKyMYPTUva@fedora>
 <20240221-acts-decade-76d3d69e8e4d-mkl@pengutronix.de>
 <ZdX3xgM36iOVhr3V@fedora>
 <20240221-juggling-uproar-9518b4901f41-mkl@pengutronix.de>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 26 Feb 2024 13:36:40 +0100
Message-ID: <877circsh3.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Wed, Feb 21 2024, Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 21.02.2024 14:16:54, Matias Ezequiel Vara Larsen wrote:
>> On Wed, Feb 21, 2024 at 01:49:31PM +0100, Marc Kleine-Budde wrote:
>> > On 21.02.2024 11:37:58, Matias Ezequiel Vara Larsen wrote:
>> > > > > +The length of the \field{sdu} is determined by the \field{length}.
>> > > > > +
>> > > > > +The type of a CAN message identifier is determined by \field{flags}. The
>> > > > > +3 most significant bits of \field{can_id} do not bear the information
>> > > > > +about the type of the CAN message identifier and are 0.
>> > > > > +
>> > > > > +The device MUST reject any CAN frame type for which support has not been
>> > > > > +negotiated with VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MUST NOT
>> > > > > +schedule the message for transmission. A CAN frame with an undefined bit
>> > > > > +set in \field{flags} is treated like a CAN frame for which support has
>> > > > > +not been negotiated.
>> > > > > +
>> > > > > +The device MUST reject any CAN frame for which \field{can_id} or
>> > > > > +\field{sdu} length are out of range or the CAN controller is in an
>> > > > > +invalid state with VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MUST
>> > > > > +NOT schedule the message for transmission.
>> > > > > +
>> > > I am not very familiar with CAN but how does the device figure out that
>> > > the can_id is out of range?
>> > 
>> > In classical CAN we have the standard CAN frames, which have an 11 bit
>> > ID, and there are extended CAN frames, which have 29 bits ID. Extended
>> > frames are signaled with VIRTIO_CAN_FLAGS_EXTENDED set.
>> > 
>> > So if a standard frame uses more than 11 Bits of CAN-ID, it's considered
>> > out of range.
>
> Another option would be an extended frame (VIRTIO_CAN_FLAGS_EXTENDED
> set) and using more than 29 bits.
>
>> Thanks Marc for the explanation. Do you think that it would be
>> worthwhile to add that to the spec at some point?
>
> Yes that makes sense as it clarifies what's meant by out of range for
> CAN-IDs, for the valid length a reference to
> \item[VIRTIO_CAN_F_CAN_CLASSIC (0)] and \item[VIRTIO_CAN_F_CAN_FD (1)]
> might be added.

[virtio mailing lists are supposedly down for migration right now, I
hope there's some kind of backfill happening later...]

If the question comes up, it does make sense to add a
clarification... as the virtio-can spec is already voted upon and
merged, we'd need a patch on top. Not sure if it would qualify as an
editorial update or a vote would be needed, best to see it first :)


