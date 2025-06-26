Return-Path: <linux-can+bounces-3909-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064E5AEA262
	for <lists+linux-can@lfdr.de>; Thu, 26 Jun 2025 17:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57CF816464C
	for <lists+linux-can@lfdr.de>; Thu, 26 Jun 2025 15:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85462EB5B9;
	Thu, 26 Jun 2025 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="onn3UqYK"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1462EB5B4;
	Thu, 26 Jun 2025 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951084; cv=none; b=A9fTAmVfwN52lU8o8ZtRb6DKlezM9grzvhFs4MYyMErSu6InH2zhS35t9wmeGjV+2z6iDoyy5g1kPu5JQRwLgkb73OrqPV1z/iBdRAllAxdoGfgZcHgsJtZPoPnvMfKuYIWcfouUfPUpi+Fkqyumu9b+dhVF3RiJdprbI83L020=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951084; c=relaxed/simple;
	bh=+xtxXrEpwnCTyj2Ee/uZrB9xYrKZ1H1qBeQh0AWvh18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TvDZ7i5o+s++/lRWGItICLMPgYvj1tr8tiGI80R9cOA5w9v8IIt6CnmWK3RUx8uStl8alr08+O+/2f7n9Q8+5x34Jw1dgqqXxOzFzTaJ4ocLU0W0WqHzfJRRj6ycBwp/togio6SnJ0DcB5gwBg1ry+djg7FHFO64g79MfhQUSMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=onn3UqYK; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1750951074; x=1751555874; i=markus.elfring@web.de;
	bh=+xtxXrEpwnCTyj2Ee/uZrB9xYrKZ1H1qBeQh0AWvh18=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=onn3UqYKS6i+EKf1JLbXyDAeHWAiwxBzdr4oT+LQIcU0TPk3bXkVQ/wxMEDVnvEF
	 AyVTyDhfiLjOibbO/3SOdbDT1dGkVHKRNUfrfdzEzbT+Jby/kNZ7eQDjeUABwBmZt
	 fB++oMjrWwq6hiCDcYg6AgcAvowaVCP/BtX57P5s8F4mmb0wfQ+QwvLIsFQ2RntEL
	 gJnwtgZcKF3yqpQDRKFUQyqJU+St3QK3PETZKKBehJfAYrN42ot+6l/tKGSXPeMCZ
	 QrycCXTCylREAAmCv3QiqTGe8Eo7uRCRBZRwRoQ5h7HYuV1kGgCi84LZG5z4gyCml
	 AllgpyA9qewTTa6ZfA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.202]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbCHy-1v1xFq1paC-00iTHu; Thu, 26
 Jun 2025 17:17:54 +0200
Message-ID: <53bbf2fe-ba48-4ce0-b97e-0cb60860f937@web.de>
Date: Thu, 26 Jun 2025 17:17:53 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] can: ucan: Use two USB endpoint API functions rather than
 duplicating their implementations
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Chen Ni <nichen@iscas.ac.cn>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>
References: <bf5442d1-34e0-495f-8a56-4e47f53ca4ad@wanadoo.fr>
 <a7a00125-b393-4283-a7dc-6c80ced8e7e6@web.de>
 <c96a5d2c-0ee1-4e3e-a95d-d38a8f668feb@wanadoo.fr>
 <0768a008-d4a9-41ec-bc47-1e7c63362296@web.de>
 <c04376f2-6ab7-4256-8bdc-aa6ff3ea88b4@wanadoo.fr>
 <7e6f8929-6665-45af-b01b-167a1aa80305@web.de>
 <CAMZ6Rq+PEZWzxNYDODq-Rz_Y8T_XEihyZKoY-MYo6bn5ATaGLQ@mail.gmail.com>
 <1e64bcef-33f1-4295-b91f-d4598b32b866@web.de>
 <57815326-740d-4053-8b85-c5e57d7cec90@wanadoo.fr>
 <e70a929f-a5c5-487e-9231-61b5423115db@web.de>
 <20250626-opalescent-tireless-locust-564d48-mkl@pengutronix.de>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250626-opalescent-tireless-locust-564d48-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ql4vrK+O14yGPd78TEnUMdkDWqmHfZGpfzxlIfILs13S9dNLfJ8
 BFhg44P590f8jGXnwGAAitnqO+gwFEdp5uN+umzT0ZjlRwbb7u2QLPUDeU4HIqflHmNkIR2
 l9b5xAg/eFk6oGOJmXbQGTm4NO0Pef2qpQpthDH3oD097kYw87l7urpwm0cFOzcdcv/1US2
 pA11hhF95bGdyzcKkefgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R4v5J6+OP8c=;8P1lDYyrYvlxJBv8E7E8tz2AQEz
 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
 Vz3jrlg5fGQ==

>> From: Markus Elfring <elfring@users.sourceforge.net>
=E2=80=A6
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>=20
> Sorry, this patch is not Signed-off-by its sender.

I find my Developer's Certificate of Origin appropriate here.

Regards,
Markus

