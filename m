Return-Path: <linux-can+bounces-2220-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AD49D9099
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 03:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5407B1698FB
	for <lists+linux-can@lfdr.de>; Tue, 26 Nov 2024 02:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207467E105;
	Tue, 26 Nov 2024 02:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="HtrT5Oz0"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965D112F585;
	Tue, 26 Nov 2024 02:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732589981; cv=none; b=CO8iemyZlYIeMnDQBDHv0cheFbHyY8fzfCAuW6RhmWGWU4z0kSO38mPAaPn8SE0HJXUy66+ZPPLe/Cmmpj4mgHMDGfFX8mUiyqD7iwkTnOtZpxofDvqjiFdkfz6sh6PHfVUvXtTdZHyXvIVDlRXtTfxgGLWbh55VR8Cv3JMsBjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732589981; c=relaxed/simple;
	bh=yMNIfEnFygUQiQ2NXOEDA0IrdLPQPdzFeD5QZDRoRKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ph2FxkePNXSOWshmkfl5ER8OuBiLU69PeJGqQDElZq0Cs76f+oVp/ZlVzDCZ01v7ijp5yy+1zcserEXWZoEEQjrWxZtzhzSmHQMokZjk2oUWHV2eI5BXPjewA9BKLv76Oo96kRiDR3yyWCQev/2Bpg4tkapOltJCqMz9id+h+qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=HtrT5Oz0; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id FlnOtBIVte0OWFlnQt2Cm5; Tue, 26 Nov 2024 03:59:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1732589970;
	bh=J+FJNTnJc4kElKhFDk7mqJ/nB5tWPYGf3iBV9WUPffQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=HtrT5Oz08AfrDqGRQ7qg3usYhQvPVM+dtausm9ZERn1BcY1Y+Be1m0yNSxEyCY9+m
	 8aBbfrYOYPRJtXzz7ImO71h+XPqLcezJNoopgPjakQNN9SJXZLjXFpXtPTia0sn9XR
	 /LZOAvjfWhINYmYHQMVMQrKkkW5ZQMs1RsdibpDSURvI43n31opQs+DgBgOOuVeKUx
	 EYk2rwRp+ZLPxLbdb1VhcZjNmSwFaZli8FEO/uvyJP4I3A64gEeVVZtXDWbgq0OJOU
	 CzGuzIk8wgs9kMuP64ZVLT9lwNFuxRwa6qE6Z2yVvuVJ++sR+zku5WY9DDPd2lW/uf
	 uuwO2pRiBBvkw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 26 Nov 2024 03:59:30 +0100
X-ME-IP: 124.33.176.97
Message-ID: <629a6722-d723-40be-a3e3-402904737925@wanadoo.fr>
Date: Tue, 26 Nov 2024 11:59:22 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] can: flexcan: Add quirk to handle separate
 interrupt lines for mailboxes
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, NXP S32 Linux <s32@nxp.com>,
 imx@lists.linux.dev, Christophe Lizzi <clizzi@redhat.com>,
 Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>
References: <20241125163103.4166207-1-ciprianmarian.costea@oss.nxp.com>
 <20241125163103.4166207-3-ciprianmarian.costea@oss.nxp.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
In-Reply-To: <20241125163103.4166207-3-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ciprian,

Thanks for the patch.

On 26/11/2024 at 01:31, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> Introduce 'FLEXCAN_QUIRK_SECONDARY_MB_IRQ' quirk to handle a FlexCAN
> hardware module integration particularity where two ranges of mailboxes
> are controlled by separate hardware interrupt lines.
> The same 'flexcan_irq' handler is used for both separate mailbox interrupt
> lines, with no other changes.
> 
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Yours sincerely,
Vincent Mailhol


