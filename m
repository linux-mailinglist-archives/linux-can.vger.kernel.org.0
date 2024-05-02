Return-Path: <linux-can+bounces-538-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3F28B9FE7
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 19:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5032856FD
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 17:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ABF171081;
	Thu,  2 May 2024 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="GYtJ2PJy"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFB717106F;
	Thu,  2 May 2024 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672704; cv=none; b=B1CAiW1oa/ueM+Zl5lTaqUKnqLOkrSD9lY4/stHhP08rJEQJyzIhuQkcOI1LmEzFqPuf1q/Ghm/fJ/SuPhHTXYSgIKotS+SnlLxHFqaXp7UrtclDPs6z7hwXNS+Q42v43g1Tvkm9JaOegDv1MGSuuQuSoqhLXeEJOcuVnlDjweg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672704; c=relaxed/simple;
	bh=hPvWHIKHOLLZg+RYAssh+cqqvv0iLnjyhrFBvRcUh1s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EgRYLKRFTe9oAapAD0q7TxwJFNLKVKgIR83Eb7rlVoIzK8hxLphpqlfFnxhDHK2JRaJV0d96dypr7A0Ryp55umhyaxXQg/4OqVbPUP5Y86ja/xl/ur+qUDtOim3mzC1ia5JZJXum+ZHwlyy63Tu4Dq/FzlXAIhSZqcJxqB23oRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=GYtJ2PJy; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=54XLdwy/ecV6ue5R6kYST/HDSq5RRwsTeNeLlM8uqKU=; b=GYtJ2PJyngGUUvSkz0AQp0a6DI
	09VnAC7Tv5lkOArrwfoYvhSBrJvqf6kPlusHooFm41BExGb0seBW2jGX8Z0RRuegZasbyXDQb0+WW
	K7PCcag2Q/9dDTapiFo+mWqhu1MhcF9URRvOxK6UDiNPR71DxoZ6KiPQlZWtitUsCidE=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s2agz-001ZYi-2t;
	Thu, 02 May 2024 19:58:02 +0200
Message-ID: <95ec67608b913913f94c4fa767fca4221c772dae.camel@hexdev.de>
Subject: Re: [PATCH v2 08/12] can: lin: Add special frame id for rx offload
 config
From: Christoph Fritz <christoph.fritz@hexdev.de>
Reply-To: christoph.fritz@hexdev.de
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin
 Tissoires <bentiss@kernel.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Sebastian
 Reichel <sre@kernel.org>,  Linus Walleij <linus.walleij@linaro.org>,
 Andreas Lauser <andreas.lauser@mercedes-benz.com>, Jonathan Corbet
 <corbet@lwn.net>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 linux-can@vger.kernel.org,  netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-serial@vger.kernel.org
Date: Thu, 02 May 2024 19:58:00 +0200
In-Reply-To: <1c56d103-bc2c-489f-a72c-875b8b8cfe71@kernel.org>
References: <20240502075534.882628-1-christoph.fritz@hexdev.de>
	 <20240502075534.882628-9-christoph.fritz@hexdev.de>
	 <1c56d103-bc2c-489f-a72c-875b8b8cfe71@kernel.org>
Organization: hexDEV GmbH
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2024-05-02 at 12:27 +0200, Krzysztof Kozlowski wrote:
> On 02/05/2024 09:55, Christoph Fritz wrote:
> > A LIN bus supports up to 64 identifiers in one byte. This commit adds a
> > special frame ID, beyond the actual LIN identifiers, for signaling RX
> > offload configuration requests. This ID will be utilized in future LIN
> > enhancements to the CAN broadcast manager.
> > 
> > Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> > ---
> >  include/net/lin.h | 1 +
> 
> You just added this file in other patch. What is the point of splitting
> line-per-line additions?

My intention was to make the review process easier by separating the
BCM (Broadcast Manager) logic from the basic driver implementation.

> There is no user of this in this patch. Squash it with the patch adding
> the file.

OK

v3 is coming up

Thanks
  -- Christoph


