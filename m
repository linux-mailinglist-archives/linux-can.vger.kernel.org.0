Return-Path: <linux-can+bounces-197-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B34FA847096
	for <lists+linux-can@lfdr.de>; Fri,  2 Feb 2024 13:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6720F1F2CCE1
	for <lists+linux-can@lfdr.de>; Fri,  2 Feb 2024 12:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB3D17CF;
	Fri,  2 Feb 2024 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+jTTNYt"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEBF185A
	for <linux-can@vger.kernel.org>; Fri,  2 Feb 2024 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877927; cv=none; b=jqinCUuIiQWjATpQcKCdlwTyiqPxAZunEtFjEGVzeU4MerNo/xYNDPzgWHZ6Zz4pnkmPF34JC484CBPyW6imZAMCBLGhlFEGcxNmN4OB0a9Dyprnc3NAXz4h/3gII1YBjU5Mppau70qmnqzqn8qDqZwhuGRC/B+k1K1e8WMts2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877927; c=relaxed/simple;
	bh=XqeNK/FBug/xgsa8dI9kK6vco2N7uNjfbXrUthvegQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SHdpINmFK13tjGeE5KC4QtJW75qxM97eyd27GNwoPycCIzXjEceu/VG+LaBUiWr8qCfNfZtfiK4cthxUxYAHC0geCX7y2Pt+C+qJLJhkAPax+ljA5u2s1EjL13IaYzWZd1gmuzenZnP2Vou6HdP7xS8SMFi05ICCWlnhDn2WRiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+jTTNYt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706877925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XqeNK/FBug/xgsa8dI9kK6vco2N7uNjfbXrUthvegQM=;
	b=X+jTTNYtODYQc7Lc9tFWJrwl4Hw4V9rPRCcfUhz9sEEUG50DeE4wKs1NrSk3tIYmHevufN
	axbh1EoM4Z3ql+NCkuMs6VlRxAdhXhN0k8TMubXH9k1+EVpTSZyREFpw6rLN+x/ImK8eJC
	8G2KpZQMLnQIsfXpRZqfr9okA32+/Qs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-iwndiQb0MpywVP_CBbUWuQ-1; Fri, 02 Feb 2024 07:45:20 -0500
X-MC-Unique: iwndiQb0MpywVP_CBbUWuQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6653083BA85;
	Fri,  2 Feb 2024 12:45:20 +0000 (UTC)
Received: from localhost (unknown [10.39.194.111])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A56D2166B35;
	Fri,  2 Feb 2024 12:45:19 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@opensynergy.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 linux-can@vger.kernel.org
Cc: Harald Mommer <harald.mommer@opensynergy.com>
Subject: Re: [virtio-comment] [RFC PATCH v3] virtio-can: Device specification.
In-Reply-To: <87ttnemuon.fsf@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <ebc57e36-d822-4264-a763-b530482b2669@opensynergy.com>
 <87ttnemuon.fsf@redhat.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Fri, 02 Feb 2024 13:45:14 +0100
Message-ID: <87eddvjaqt.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Mon, Jan 15 2024, Cornelia Huck <cohuck@redhat.com> wrote:

> On Mon, Jan 08 2024, Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@opensynergy.com> wrote:
>
>> Hi all!
>>
>> I kindly request a vote.
>>
>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/186
>
> Oh, that has been a while... I believe that this still fits on top,
> although it has conflicts with virtio-spi, but nothing that a bit of
> fiddling can't sort out.
>
> The main problem is that we're currently in a bit of an unfortunate
> situation regarding voting: There's still a twice-postponed migration of
> the OASIS infrastructure coming up, and I don't want to risk the voting
> period being affected by an outage... hopefully we'll get a new schedule
> soon.
>
> In the meanwhile, if anyone could spare a few cycles looking at this,
> it'd be appreciated. Nothing jumped out at me, but I'm not a CAN expert;
> I'd be happy to open voting but for the looming migration issue.

OK, I'll just go ahead and open a vote, no reason to drag this out
further, and hopefully we're done by the time the migration _really_
happens...


