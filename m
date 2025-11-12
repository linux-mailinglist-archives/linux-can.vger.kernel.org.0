Return-Path: <linux-can+bounces-5367-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE676C53B62
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 18:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2BD500213
	for <lists+linux-can@lfdr.de>; Wed, 12 Nov 2025 17:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07A0343D95;
	Wed, 12 Nov 2025 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXafX2jo"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C8933F371;
	Wed, 12 Nov 2025 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968481; cv=none; b=hie3k2mjjwl0xICDfYd5Nfd4BCU3LFvRAe6/1UqF/JKEVg4ZD67BsNBnzjjzoMWjNENDinmXbBon+jHwHea4TL5Lxn5FvioA4huKJPAMD1z/2AadzZ3y6BBgf97L17nSNShdprMbW9wzf1B5DPGCobMKAgqA9CfPjxObzV6lumA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968481; c=relaxed/simple;
	bh=k3QziyCQz7mmZLVMCZSGgGmIYWRMCxWfFHH6xwU144g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XhAfh9ai/fsq6MXEkpp81XFv9Xk/grD4XM0ONm/k7oDXjfTYWF1RajAkRqqWsp9utw57567zUTEVJp6VtGVrlydsmB0zvTfF2LXjjJRMB6QOAtT1g+OIFLH5fnfIA92tUBcshNtlIpxrEgD3T8ajnN9vez/KA/n7yL4E7+LFxDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXafX2jo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDE3C4CEF1;
	Wed, 12 Nov 2025 17:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762968481;
	bh=k3QziyCQz7mmZLVMCZSGgGmIYWRMCxWfFHH6xwU144g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RXafX2jovIvmYmIUObfRZEtwKeNW0KSuHdpmsBBXA0MOK97tXNMutTeR/f5Yav64v
	 LUs+WMqLLPC6GXwNNeYqv3OeII1s760mrVVKY5x7iLpgG26lpCUPoF2qPGANQw1F43
	 0xQiw4+CK+8E9TuV9vUjmLu7WNyqF2Ba2bENsCI7pAlamhr3geCFZVVjVDKJ7BxqOe
	 hXFA3o789qtCG9yyXJZszqUeX3CzpSP9ZBWX0i8LRcOBc8zQE3Fwk1AHtMySlfOnEB
	 jX6NSPf70uYAfQJ2UIHgnf6jKlaK9nysyu5VV5MToH1rKZIWe1J45v89sCumCPU2J7
	 0rsILtenC0wfw==
Date: Wed, 12 Nov 2025 09:28:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Gregor Herburger <gregor.herburger@ew.tq-group.com>,
 Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, Manivannan Sadhasivam
 <mani@kernel.org>
Subject: Re: [PATCH net-next 07/11] can: mcp251xfd: add workaround for
 errata 5
Message-ID: <20251112092800.290282eb@kernel.org>
In-Reply-To: <20251112091734.74315-8-mkl@pengutronix.de>
References: <20251112091734.74315-1-mkl@pengutronix.de>
	<20251112091734.74315-8-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Nov 2025 10:13:47 +0100 Marc Kleine-Budde wrote:
> +static int
> +mcp251xfd_regmap_nocrc_gather_write(void *context,
> +				    const void *reg_p, size_t reg_len,
> +				    const void *val, size_t val_len)
> +{
> +	const u16 byte_exclude =3D MCP251XFD_REG_IOCON +
> +				 mcp251xfd_first_byte_set(MCP251XFD_REG_IOCON_GPIO_MASK);

Looks like this is added by the next patch :(

drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c:48:59: error: =E2=80=98MCP=
251XFD_REG_IOCON_GPIO_MASK=E2=80=99 undeclared (first use in this function)=
; did you mean =E2=80=98MCP251XFD_REG_IOCON_GPIO0=E2=80=99?
   48 |                                  mcp251xfd_first_byte_set(MCP251XFD=
_REG_IOCON_GPIO_MASK);
      |                                                           ^~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~
      |                                                           MCP251XFD=
_REG_IOCON_GPIO0

Do you do rebases or do we have to take it as is?

