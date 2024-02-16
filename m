Return-Path: <linux-can+bounces-296-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2176D858417
	for <lists+linux-can@lfdr.de>; Fri, 16 Feb 2024 18:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3D81F28161
	for <lists+linux-can@lfdr.de>; Fri, 16 Feb 2024 17:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C3B131E2C;
	Fri, 16 Feb 2024 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNVUIXhX"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044D8130E3D;
	Fri, 16 Feb 2024 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708104426; cv=none; b=NRVlUFxkpRG/DkxW5BNZBy2QTVE6+4xXlbq2f8qDH3JgnJ4yYRJItR9UMpwo/iDEI572pub2woEiIc+95LByf9Ec3xLD6EUusHdskOveaqkXx2HYbli5A5qoDoVeSl8wQI4LdkmJ2fE1iOuOy9onfIvrixji5O7H/4hw/blJDfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708104426; c=relaxed/simple;
	bh=pHPAK4RE3qzV+K9xTITuogvkre5ptmDnK4AELxLbjxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8TbjdH0gsjidNgiLqfvsyHV3NY8Oq9PqK4Tvsuv7CCk2rp+ZIq9wIYYuG6aCwflu6mqoO5wIJsynqRqIyJOfln8Wl6oq+QUQ1Ss/qskccMnjLNjxLDKXkdwX4Wn2Bss34F4ZKbcrgxpfhffqrKBGm16Yp2n2cPbchCVymJmApk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNVUIXhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76842C433F1;
	Fri, 16 Feb 2024 17:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708104425;
	bh=pHPAK4RE3qzV+K9xTITuogvkre5ptmDnK4AELxLbjxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KNVUIXhXfbTTqBhYV7fjO8zz4ayYXh+g/C15M6zTl9Qrpu9/68IHlAPhT8Cy8nQqV
	 fVbPWGw2TYbnJVdsdNV3XYnwf7uSjlkq/yt21ZB0dPSF5vpWFEcSnmvxeHhg8FwAQY
	 RGCiOzeH630lBgsPUAnfjsz+RtTti1qG6hKOOy75wwoplS+HjF+P3CKF1jlMAFTRWi
	 yV4qkQpgvd8NaH4vI3XMCHbcfn6wmxIqQKZtIgfiAZ8aPwNn2QfSNhD1c09WO/Ob5w
	 a0bwVWhIUHVCyONAOCUH5D2R6PbSeesjL2c939BmBYtoeRMGZ1zWrEA/vSK2+rogvW
	 8/X5S5lZIlxSQ==
Date: Fri, 16 Feb 2024 17:27:01 +0000
From: Simon Horman <horms@kernel.org>
To: Daniil Dulov <d.dulov@aladdin.ru>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] can: softing: remove redundant NULL check
Message-ID: <20240216172701.GP40273@kernel.org>
References: <20240211150535.3529-1-d.dulov@aladdin.ru>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211150535.3529-1-d.dulov@aladdin.ru>

On Sun, Feb 11, 2024 at 07:05:35AM -0800, Daniil Dulov wrote:
> In this case dev cannot be NULL, so remove redundant check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 03fd3cf5a179 ("can: add driver for Softing card")
> Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>

Hi Daniil,

I am not sure that dev cannot be NULL.
But I do see that the code assumes it is not, and would crash if it is.
So I think that, functionally, your statement is correct.

	priv = netdev_priv(dev);
	card = priv->card;

Reviewed-by: Simon Horman <horms@kernel.org>

