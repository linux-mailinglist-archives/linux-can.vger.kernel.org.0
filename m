Return-Path: <linux-can+bounces-2453-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 898DA9F725E
	for <lists+linux-can@lfdr.de>; Thu, 19 Dec 2024 03:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830B916A80D
	for <lists+linux-can@lfdr.de>; Thu, 19 Dec 2024 01:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693101A0732;
	Thu, 19 Dec 2024 01:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oooVZ2JH"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4146B78F5B;
	Thu, 19 Dec 2024 01:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734573070; cv=none; b=MhjSAScB6S2pqXM6SBEtLmiJeFPfn5qsc0cpifk5YlotghrygKC5TI2XvIkhU7+QN5r8wYoQ95Rkw6wiUhE3zhgREUHjtnBzDhP3vjpDBwhntaaO5qDBTUQW9MhYFCPtSt4eSEYuQ4s1cg/qk7zVgIqiUX0l+5rT1PgWeE5jF3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734573070; c=relaxed/simple;
	bh=9hJfrK1FTuG2yn6hR6nYLqiBnlesKyDDJMN5Kjiec8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4Xm1NF4JVc+RGfsCZREcmmUYUzMyCbJgBnkkWyglVWBh3I3SozJ11EbO7ekIULZEehUk/BhfHh1Y5MaGdJPMv4Mkt4pRlAYnQ3RwJZSoxG7ASvXh3xpqTAaiD5bU0cgru0OyNEXPG/Py21Hjcqb5pjPnJ6kjUBqzsMQjIjDYF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oooVZ2JH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEB4C4CECD;
	Thu, 19 Dec 2024 01:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734573069;
	bh=9hJfrK1FTuG2yn6hR6nYLqiBnlesKyDDJMN5Kjiec8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oooVZ2JHq6LZgzG5VUJ3PyxhL7Wg8oR8f/kB3TJfeob1nZ6QvY1EbHN6t1l98r470
	 mdiZQJ1T4OPRBWsaaHociyZ4JIaBtblsF3zBLGw4m6//9WSfN6L7uOz9OSA48GHq73
	 +2bDhKsuQbAlbSOk12UchFmSI2+7HYfuk30WAwU4vHw8IXCKyQstIWe9cpzxIkiruV
	 g+qRX4bu2xss4QN06Agp/vYMgQPfA7Gy+bNKhq2V96e+8yHiCjrMkdVh33JT+ZpcUg
	 j2TsaRgs3olzg+b3PWMn8PnJbbgtbhRctfPxQx7cGye5ILWMA5YirYig7v9mTGDAAV
	 UbZh0C06YBLew==
Date: Wed, 18 Dec 2024 17:51:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, Markus Schneider-Pargmann
 <msp@baylibre.com>
Subject: Re: [PATCH net 2/2] can: m_can: fix missed interrupts with
 m_can_pci
Message-ID: <20241218175108.39f6f79e@kernel.org>
In-Reply-To: <20241218121722.2311963-3-mkl@pengutronix.de>
References: <20241218121722.2311963-1-mkl@pengutronix.de>
	<20241218121722.2311963-3-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 13:10:28 +0100 Marc Kleine-Budde wrote:
> +	while ((ir_read = m_can_read(cdev, M_CAN_IR)) != 0) {
> +		ir |= ir_read;
> +
> +		/* ACK all irqs */
> +		m_can_write(cdev, M_CAN_IR, ir);

Perhaps consider adding a cap on how many times this can loop 
as a follow up? Maybe if the HW is bad all bets are off, anyway,
but potential infinite loop inside an IRQ feels a little scary.

