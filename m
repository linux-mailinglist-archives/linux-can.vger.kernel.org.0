Return-Path: <linux-can+bounces-649-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF1A8C91E4
	for <lists+linux-can@lfdr.de>; Sat, 18 May 2024 20:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64332B20F56
	for <lists+linux-can@lfdr.de>; Sat, 18 May 2024 18:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D35E46B9A;
	Sat, 18 May 2024 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="eweixlyF"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3F0D53B;
	Sat, 18 May 2024 18:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716057022; cv=none; b=CkRgOR8nxU7zd07dNz3T56j9f/yUSEK2lVZkwN/IUvSUgOnf3xYS9K2yD0ldaJUwpD1c7is6H3qHViJeRN2aSxjhreoRLPpJvNzGk2ej2hVQ5WkASWt7tqnqwrqXKBXATzmVAbijq7nEd9Z/jlFf47L6Yr4U/aO90jWcpCpY8LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716057022; c=relaxed/simple;
	bh=QD0AeuS6ruZUVuMGyzujUhdrK/dqTqMUs5qdHROyZ2c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q+ihEpARIwOLIPdfnhGKWoyz6KDziqUEl/mcLB6DSnnV8cM0ddpI41C39r/QCbZ0Lt1xovMWgVKQBJEGL3LsdiAw7vi3sfTKKFsZfOOCJNchN3O/4+BbWl+Ht3ryOrNoW0hOWHqiQlwO8SVWlqoUkMdrtOqvVDDuZ0WwERp6g7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=eweixlyF; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MQd+r43EMCvOi0g8lQTgHWFiUz5ZmsoKmS6F6rcfff8=; b=eweixlyF1OjlSUo84mXPkdXbv3
	MvDHsxO3j6jiPPFghHQjd9qz0FYO6H2Nl73/YAMqssQltUWNLRLAi9XHCTsjGRjHPsnbS6NhwLXoP
	Vk84tgQVBsQ1UGIusAff9ZY72lX5x3/AHZOkqZ5vEELmSZr0WqALJ8lbaIAqlLLhjf5o=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s8OoU-0026If-1n;
	Sat, 18 May 2024 20:29:47 +0200
Message-ID: <d25357857f49efb38a80ef48becf2a15ecbaa8e4.camel@hexdev.de>
Subject: Re: [PATCH v4 00/11] LIN Bus support for Linux
From: Christoph Fritz <christoph.fritz@hexdev.de>
Reply-To: christoph.fritz@hexdev.de
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Jiri
 Slaby <jirislaby@kernel.org>, Simon Horman <horms@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Vincent
 Mailhol <mailhol.vincent@wanadoo.fr>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <bentiss@kernel.org>, Sebastian Reichel <sre@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>
Cc: Andreas Lauser <andreas.lauser@mercedes-benz.com>, Jonathan Corbet
 <corbet@lwn.net>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 linux-can@vger.kernel.org,  netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-serial@vger.kernel.org
Date: Sat, 18 May 2024 20:29:45 +0200
In-Reply-To: <20240509171736.2048414-1-christoph.fritz@hexdev.de>
References: <20240509171736.2048414-1-christoph.fritz@hexdev.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40app1) 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> This series is introducing basic Local Interconnect Network (LIN)
> (ISO 17987) [0] support

I just wanted to let you know that I'm unfortunately personally busy at
the moment. I will resume addressing the remaining issues with v5
sometime after the current merge window.

thanks
  -- Christoph


