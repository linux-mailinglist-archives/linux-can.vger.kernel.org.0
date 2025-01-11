Return-Path: <linux-can+bounces-2596-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23455A0A52D
	for <lists+linux-can@lfdr.de>; Sat, 11 Jan 2025 19:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D74707A133C
	for <lists+linux-can@lfdr.de>; Sat, 11 Jan 2025 18:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F111B4246;
	Sat, 11 Jan 2025 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b="mIbj8BiV"
X-Original-To: linux-can@vger.kernel.org
Received: from violet.fr.zoreil.com (violet.fr.zoreil.com [92.243.8.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA6F1494CC;
	Sat, 11 Jan 2025 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.8.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736618768; cv=none; b=jjZb6yMtdwtsSWRuNDJuznN5ADfT5ZT6axreiqsEsozvSMJcCCr3rC1eX7qNvTD8srN1KwPbOtB8W9nwrYaohEbZp94kcw5WOc28dwnVs8sImfR0am2XthZRFeH5sq+9547KiWL0K8bs9t5PRUO3/Ux06VRf3GwNQPI84T6dy9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736618768; c=relaxed/simple;
	bh=KCJpf/fycjR5R30opdT+J866wNUYGNty9NCTTQfwMzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+aOlB/4Ru4rVV0Mz1StrNEBG2n+WSYxLOE+C7++p0CxleEhvvciwa4hMuHWSrV73KVDZ2/+wqzMSpBQc5pcK2dU1tcQzoQAwIANyIbw60ZHVQW46CD1CyUDKywJrhbqNJaZULYGZHjXRJpFgIBq6Mvjwrt4BCaXtjJeKoU+Fao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fr.zoreil.com; spf=pass smtp.mailfrom=fr.zoreil.com; dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b=mIbj8BiV; arc=none smtp.client-ip=92.243.8.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fr.zoreil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fr.zoreil.com
Received: from violet.fr.zoreil.com ([127.0.0.1])
	by violet.fr.zoreil.com (8.17.1/8.17.1) with ESMTP id 50BI3bJx1661624;
	Sat, 11 Jan 2025 19:03:37 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 violet.fr.zoreil.com 50BI3bJx1661624
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fr.zoreil.com;
	s=v20220413; t=1736618617;
	bh=eRjZF3MpIXcgnFTHyt8fWhGiLLRbiirfj+vTsqAXcU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mIbj8BiVRo/BxaZB7FTqCP2f6Us6OiLVFCqbMRQK6TQcthUaU33ypzwEiTc4VVzFE
	 8NTqMhiQbTFMYUAWUbLnJzxrmMeUKDlmabW5kG6iliArSIwApDWvKl1UsQSgFM+Du8
	 9IFsz6nTNA/4L76DX/Meq7SjoCw+AgNQjR4eZG7E=
Received: (from romieu@localhost)
	by violet.fr.zoreil.com (8.17.1/8.17.1/Submit) id 50BI3bfD1661623;
	Sat, 11 Jan 2025 19:03:37 +0100
Date: Sat, 11 Jan 2025 19:03:37 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
        mkl@pengutronix.de, mailhol.vincent@wanadoo.fr,
        linux-can@vger.kernel.org
Subject: Re: [PATCH net-next] can: grcan: move napi_enable() from under spin
 lock
Message-ID: <20250111180337.GA1661553@electric-eye.fr.zoreil.com>
References: <20250111024742.3680902-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111024742.3680902-1-kuba@kernel.org>
X-Organisation: Land of Sunshine Inc.

Jakub Kicinski <kuba@kernel.org> :
> I don't see any reason why napi_enable() needs to be under the lock,
> only reason I could think of is if the IRQ also took this lock
> but it doesn't. napi_enable() will soon need to sleep.

Anything that depends on the napi handler being run may also behave
differently because of 'priv->resetting = false;' and
'priv->closing = false;' also done under the lock after napi_enable in
the original version.

Both priv->closing and priv->resetting are always accessed with lock
held so it's fine.

(nothing to chew in grcan_start either)

Reviewed-by: Francois Romieu <romieu@fr.zoreil.com>

-- 
Ueimor

