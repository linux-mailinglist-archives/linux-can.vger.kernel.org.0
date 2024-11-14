Return-Path: <linux-can+bounces-2021-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BF39C8181
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 04:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AFDEB22A6D
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 03:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1D915575D;
	Thu, 14 Nov 2024 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r837WVoo"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396432309B8;
	Thu, 14 Nov 2024 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731555431; cv=none; b=itpFnep/+DsIsBLF4aN+R1cG/GtB/D1V0gBZ0QzbkAn5fSSEJJ5rJjBgVSb9qjxPKxUj/8Rmo99MOTnvoQLWbtlDVIVzP4SloIaNTO1EgKzBIPFmOkr/xDsJ0xdsq25axRb5coUmy4Q4n+ah73VcuuNjP/MfiZPscUAf+aDnHkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731555431; c=relaxed/simple;
	bh=jFpyI3nOdDf01MdExjgHPu4NLF2fuwE/+slLVZ48g9o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWSDeYVDZPKnCwqy+WrQSd/+c940mMzEOzOfhFgZngOTWCOkvrjxzltlcZyJi8UYgdLImFJ+9Bi1Iuuvtu+7Z49JSQrFSbEko+zQvqLZ96wuKu1Vf7jB6rDhxwwAkbriwOapx/ETk4pt+BYChKrXJwKjvKbfWpCts9o3oVVL2nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r837WVoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79731C4CEC3;
	Thu, 14 Nov 2024 03:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731555431;
	bh=jFpyI3nOdDf01MdExjgHPu4NLF2fuwE/+slLVZ48g9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r837WVoozJRURRFSvLLQf60pnpa5hpAN4IyOp8f60FfokeF1CXzss79hnUBem6g+4
	 7aNpeqAzRdXPxi6S+8geG87H7dl/YYGDjdfzzf9ulqNaHKPfayBxY6RF9RUJndpXXZ
	 3WuumvQW8CjhI3Rj+YYQHzG96rC2miV2U7rAcV22V+8zUKFSP0/zwkfl1j7Kxm1JcT
	 WQTb3jWe+KMqFkfYAT/v/gbco4kYaG59ZW3nOlxy57+fX86wk06klYPgATonLiZT1b
	 lLIMRU95NjUIJrPllCF7bH+QtKobg1qh+ERF2bfOqFkv6/a0GmSoGeq5ZuTC8apfRq
	 nPrXdvStCg9Ug==
Date: Wed, 13 Nov 2024 19:37:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Sean Nyekjaer <sean@geanix.com>, Vincent Mailhol
 <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] can: tcan4x5x: add option for selecting nWKRQ
 voltage
Message-ID: <20241113193709.395c18b0@kernel.org>
In-Reply-To: <20241112-hulking-smiling-pug-c6fd4d-mkl@pengutronix.de>
References: <20241111-tcan-wkrqv-v2-0-9763519b5252@geanix.com>
	<20241111101011.30e04701@kernel.org>
	<fatpdmg5k2vlwzr3nhz47esxv7nokzdebd7ziieic55o5opzt6@axccyqm6rjts>
	<20241112-hulking-smiling-pug-c6fd4d-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 08:16:02 +0100 Marc Kleine-Budde wrote:
> > > There is no need to CC netdev@ on pure drivers/net/can changes.
> > > Since these changes are not tagged in any way I have to manually
> > > go and drop all of them from our patchwork.  
> 
> Does the prefix "can-next" help, i.e.:
> 
> | [PATCH can-next v2 0/2]
> 
> which can be configured via:
> 
> | b4 prep --set-prefixes "can-next"

Yup, prefix would make it easy for us to automatically discard !

> > Oh sorry for that.
> > I'm using b4's --auto-to-cc feature, any way to fix that?  
> 
> You can manually trim the list of Cc: using:
> 
> | b4 prep --edit-cover

My bad actually, I didn't realize we don't have an X: entries
on net/can/ under general networking in MAINTAINERS.

Would you mind if I added them?

