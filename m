Return-Path: <linux-can+bounces-3925-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D661AECC46
	for <lists+linux-can@lfdr.de>; Sun, 29 Jun 2025 13:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09FD1713F4
	for <lists+linux-can@lfdr.de>; Sun, 29 Jun 2025 11:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D9D20A5DD;
	Sun, 29 Jun 2025 11:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hmeYEzDa"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F36F4C6C;
	Sun, 29 Jun 2025 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751197098; cv=none; b=EiUgnIobl+ERwo0Us8lV3XlTQogp2jXhSTlk4fug74IOIZEpLBIvR+JzgkKX+l1+OT8PoADysxo9vxGKOJz7eveGBPTcXkpJjQlFfTsFKZkH8+nUWS9pVtUOEnA0GCyF8zfycVwUqRqeTlNCRMZGMwQWPg373GQbRnjpYiFLnwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751197098; c=relaxed/simple;
	bh=u/A3a+FxwtZJZRomlvdxwkXUOI6BE+9PxTS8f5GnDWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XO93dt8V/0fHCH4t+YOA8JD1QdkJIHMf70c1BWGNNQ2MkNeBWEP1n27Txlte1wbfLjLuK5U8E4iFYr06baU1iEnwcyiB9n6keb3JxTIN9AatMxnFVJW4/sitQQBRsnlHII3cCQeHhzL7hsU2V3Y6/E9ME19vjyt7y95MxwoX0pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hmeYEzDa; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751197088; x=1751801888; i=markus.elfring@web.de;
	bh=wr92fPaRHolQpd7Yxs20PiNNfFloPYh+Bmy+ZgP9juo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hmeYEzDaahYfvpRMcyxZV4o93JwXZrxlolI6e7XMVT6lgAcP7zEMaH4UC+owughz
	 JtHtRfHr7cH6yyCcwUcv5vt8x/O40LX1vPdxIgxTOWw4ngredS9F3hUByYFXdxjVQ
	 iplINhjOYWLHTYLZIJBi9SoocOhUzX4uJlzqmxAogMJVuBwryqUZORilYE8j+ws8+
	 cqDCaruKmdlb9lhibyMqg3CVH14IphSUzfILmr4aGM+GIcud1io3IsEoi0TDb5F68
	 pokz7EGhBbuQzIbC+hBzEwoR0EfagqFGmEZp+F/0nE3hFwb8KHZn49W9TjqEUEGEY
	 zfKvDZZacvROcfizVQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.227]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M7ux4-1uaoRW1fAA-009I4e; Sun, 29
 Jun 2025 13:38:08 +0200
Message-ID: <dfc5f8b6-c433-491d-9538-af8dca42670c@web.de>
Date: Sun, 29 Jun 2025 13:38:06 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] can: ucan: Use two USB endpoint API functions rather than
 duplicating their implementations
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Chen Ni <nichen@iscas.ac.cn>, Marc Kleine-Budde <mkl@pengutronix.de>
References: <0a675827-33af-4ec4-97dc-2e4523e41194@web.de>
 <c44cf0e9-9510-4fe9-aa67-edeaa1be6253@wanadoo.fr>
 <1d773886-1657-4a90-87e1-aaaa169f5783@web.de>
 <a545127e-ee1d-44a5-bf43-149f81bda6a5@wanadoo.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a545127e-ee1d-44a5-bf43-149f81bda6a5@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fWlvJPs+SM1iAy1zOadtfByEhAEDkdROqywa3BhuAbRIII6bzZm
 m1GMufjBHQgjLxciOu6lOet1kJdbpjswGuW6cspvEZRSC2jiLH6xK9txwqslh52EIEHjVx3
 YhlTXzcjGBhXMkHrpyRqIrb4OmY/YqV4GfhVw4srBaqPbJOKKetxSWLV5XG7zPt73Exu9JT
 M6tJXUFHUsAtuo468iWHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U/Ih+SdI3Hk=;0jzat1ePlZNcxWP/+Q9M3DiGE4Z
 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
 /hRzIXhaYta58V8wHB1lLb0tivTbwm7E=

>                             =E2=80=A6 Use whatever e-mail address you wa=
nt, but if you
> fancy mixing different e-mail addresses, then just stop posting.

See also:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> git log --one=
line --author=3Delfring@users.sourceforge.net | wc -l
1263


Regards,
Markus

