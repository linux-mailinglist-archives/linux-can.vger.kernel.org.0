Return-Path: <linux-can+bounces-288-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42851857B2D
	for <lists+linux-can@lfdr.de>; Fri, 16 Feb 2024 12:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532EF1C23E3A
	for <lists+linux-can@lfdr.de>; Fri, 16 Feb 2024 11:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2031E59B40;
	Fri, 16 Feb 2024 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lyo9/29i"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A42258AAA
	for <linux-can@vger.kernel.org>; Fri, 16 Feb 2024 11:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708081745; cv=none; b=APZXmJtqBxysA+GbDBsSQQuEHXBv718pf2j7cNYgTn7aJiFRVlNP7EQdq+JqmhDfOKS//7dG6ZO4OwHGfNOezEYrhEHCjKcGVDxB3R60xIUF/P8T2RZXugfgRqHf0zPKZIiAUbcHxy9g98VfDhMWvhWgsWyKL8HbhbS2C0SMYmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708081745; c=relaxed/simple;
	bh=Bm2pxnDRCF5Y+3itulmeyIU/eDYa4Yt71dv1HrtiDn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UIcXVUy+Jf3GdZ03nCEjBBJZN9T7BsVp0lwe/9U3rtPr0SX8E+Z1kY0XWrfgVafNXi2HQw3S/jKzywBA2sZXiM3vCGszFyiP0jX6m48+b12NaOC+7UvW3CRGsn733G/4fm5xvYWXD46xsTmgJ89cFCR+LI+5lZPWyDUXSM9bm4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lyo9/29i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708081741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bm2pxnDRCF5Y+3itulmeyIU/eDYa4Yt71dv1HrtiDn0=;
	b=Lyo9/29izOv7hX+MB3805efuk8BmS0Qw32H2CUyvDXdrJUSPih9dqh5ri/kHlgLbsk7k0p
	yOfZ2XEtuDka7xDn2j3HrfdeEzTf0XyjaxKOTHacnHjVI/a21VI1/7qqkPT9h0opH/RM6y
	FLwwu5evChhe0RyTuo+9+/bclm2vg3Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-Om2yKeRtMS-jnZAO24u_lA-1; Fri,
 16 Feb 2024 06:08:58 -0500
X-MC-Unique: Om2yKeRtMS-jnZAO24u_lA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F0571C04180;
	Fri, 16 Feb 2024 11:08:57 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CD862166B4F;
	Fri, 16 Feb 2024 11:08:57 +0000 (UTC)
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
Date: Fri, 16 Feb 2024 12:08:56 +0100
Message-ID: <87sf1sfyyf.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Fri, Jun 09 2023, Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:

> From: Harald Mommer <harald.mommer@opensynergy.com>
>
> virtio-can is a virtual CAN device. It provides a way to give access to
> a CAN controller from a driver guest. The device is aimed to be used by
> driver guests running a HLOS as well as by driver guests running a
> typical RTOS as used in controller environments.
>
> Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
> Signed-off-by: Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>

(...)

> diff --git a/device-types/can/device-conformance.tex b/device-types/can/device-conformance.tex
> new file mode 100644
> index 0000000..f944ffd
> --- /dev/null
> +++ b/device-types/can/device-conformance.tex
> @@ -0,0 +1,8 @@
> +\conformance{\subsection}{CAN Device Conformance}\label{sec:Conformance / Device Conformance / CAN Device Conformance}
> +
> +A CAN device MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{devicenormative:Device Types / CAN Device / Feature bits}

I just noticed that this introduces[1] an undefined reference (there's no
device normative section for feature bits.) I'd suggest to just drop
this reference (I can do that as a simple editorial update); if we want
to have an actual normative reference for feature bits, it should be
done via an extra change on top.

> +\item \ref{devicenormative:Device Types / CAN Device / Device Operation / CAN Message Transmission}
> +\end{itemize}

[1] Easy to miss, as the current 1.4 branch has a pre-existing undefined
reference, which will go away once we finally can merge into the main
branch again and have all that craziness go away after we manage to do
the actual 1.3 release :/


