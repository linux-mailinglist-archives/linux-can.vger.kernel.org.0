Return-Path: <linux-can+bounces-6052-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FB8D0609D
	for <lists+linux-can@lfdr.de>; Thu, 08 Jan 2026 21:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31BC63032967
	for <lists+linux-can@lfdr.de>; Thu,  8 Jan 2026 20:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31DE2DB793;
	Thu,  8 Jan 2026 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyYOKcJN"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08751A23A0
	for <linux-can@vger.kernel.org>; Thu,  8 Jan 2026 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767903917; cv=none; b=ekIjUADRkBureRpcX8u423TZqKL2IPg9LnQH55JEL/iL4E7UUihuYWPYtzLb0+ks8qAxm28zjZ8USEsr9frJC/Sc8qe3l+BvK8BI1M24qTbU8dXAU1zFV9raogPulQhZUnpAeGIee0a2NbjyK6qJMqs6XkAqB9x3Y4A4gbEnTIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767903917; c=relaxed/simple;
	bh=xpMhpeHXiXswlwKrTGCxDJUFrmMrXCpS8x1N/2LbFKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjykbWOOD7Ccd3IPssP2MupkUM9hEmEZ35i3NFJffGGYKukuPGTElYt4OYokpHMVLe1+/dis+v+Yfig1WBBW23256B4ffaa9XVkG2fkuWD8Bvrq1qUHVzKEf3IguTJz3QAGqOGs0bUYbF0/2F8Ctma7pkvk/YYuOlz6arKm9vRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyYOKcJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DDCC116C6;
	Thu,  8 Jan 2026 20:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767903917;
	bh=xpMhpeHXiXswlwKrTGCxDJUFrmMrXCpS8x1N/2LbFKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MyYOKcJNSWv8Ix6/f3YB5bP2eTjJykuTXU4/gfIZM1qaW/7kHni1SgXXucMk3AJgy
	 EEMDJqy0Bq1onDZ2NvaFSlQ/vn2rVEa7rvCUpWHly8yFMcKG0l8Ca5CYcSQ4GKlmrd
	 T5U1405SKGAD51DmZFw8CW6S9dtCQ2eNG5Obg+G+sP+yFPwS5ivnxcEzZAuF4eVivH
	 2WSeHrL/V3VhqAC7cWun6qPCv5+6Hy66H106syxhBtbZ1jaZF7lOCRa31ZvUnQgr0K
	 Bi4Rye2YJZGzjOEMFPyMOLrB3Qha81ROvnHRbojP31GOrs8p3lyG+86Iij4pQZS75A
	 72tuGziV9+Atw==
Date: Thu, 8 Jan 2026 12:25:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [RFC can-next 2/5] can: move can_iif from private headroom to
 struct sk_buff
Message-ID: <20260108122516.221e9bc0@kernel.org>
In-Reply-To: <20260108160716.101883-2-socketcan@hartkopp.net>
References: <20260108160716.101883-1-socketcan@hartkopp.net>
	<20260108160716.101883-2-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Jan 2026 17:07:13 +0100 Oliver Hartkopp wrote:
>  	union {
> -		__be16		inner_protocol;
> -		__u8		inner_ipproto;
> -	};
> +		/* protocols with encapsulation */
> +		struct {
> +			union {
> +				__be16	inner_protocol;
> +				__u8	inner_ipproto;
> +			};
>  
> -	__u16			inner_transport_header;
> -	__u16			inner_network_header;
> -	__u16			inner_mac_header;
> +			__u16	inner_transport_header;
> +			__u16	inner_network_header;
> +			__u16	inner_mac_header;
> +		};
> +		/* protocols without encapsulation */
> +		struct {
> +			int	can_iif;
> +		};
> +	};

I won't accept this patch but it's a matter of taste so maybe you can
convince another of the netdev maintainers to take this.

