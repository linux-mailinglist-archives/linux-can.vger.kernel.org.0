Return-Path: <linux-can+bounces-5285-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01079C1E99D
	for <lists+linux-can@lfdr.de>; Thu, 30 Oct 2025 07:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44AE119C0E4D
	for <lists+linux-can@lfdr.de>; Thu, 30 Oct 2025 06:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148C92FC034;
	Thu, 30 Oct 2025 06:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUtU0QIV"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02782FA0EF;
	Thu, 30 Oct 2025 06:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761806219; cv=none; b=sh6fVSkTPc9nu/ivjsl5fu6sXd4UCffQ5tN8uIJkOIFQK6VSqEqQg6hQXeKvNAK1jdpwUCKUXEDsBHC6NI9xaV1x74sJdVsvgk+cSoVyp9W1dtohz+8DOLGBFcWUlz1Yr8K+wmVy9JVXnmEHF3TiXLGvEQiaKhbxq+I5xN+kwRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761806219; c=relaxed/simple;
	bh=jWy1nUiS/9rBKP8EWWYYdjr5VNQchRs5MjAga0hKfhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fsBA4SrIgKrhzdIgedyfo6RL0gxJuZozpNhR77tUU/XXh2ceORXZjUidlrVgcHbGKVEJhirFgUt2386Gc+FY6p+ZxYVeIuAOQGs1tu3LRTx2wK2YL0O8Rrmjzg0laym0hHbPXBO51CrHa9sT14EtTtR3sNDgjglhHLwE/c1ssfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUtU0QIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07564C4CEF1;
	Thu, 30 Oct 2025 06:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761806218;
	bh=jWy1nUiS/9rBKP8EWWYYdjr5VNQchRs5MjAga0hKfhY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lUtU0QIVKUazxHucs2F9UTLcUDM6aHszXUFeXCZ9g+5BmYmP/t4Ybe1fQnOnPWhpT
	 DbhhTfFMqhIWdr/Bj8OwCou8rUkVTeSYxq6JoJ8tWeJqYTr/3BanwB7934JmBMnUNa
	 Aa6Yy2weVCUYF8V0KAPKk1vwu47roC7sFixpBlA/7eDgVDHtOfG2z0HM7Vt+Jz2/sA
	 5e6/WE0Uklj57tXbBh1We8+15TG867cBNOg/Bc2PxjfCtVA90twXD06Nl09C4s2kGA
	 l9y4JiSmcVGMBDOdqXufmexNxevMZP1knrnKDWDpbTSjI+Mn9WR00d5lL5pSqVOR9d
	 tQBQKNghnVDAw==
Message-ID: <c544fdee-5b66-45dd-b3bb-75dfd8e1adc4@kernel.org>
Date: Thu, 30 Oct 2025 07:36:52 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] convert can drivers to use ndo_hwtstamp
 callbacks
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, =?UTF-8?Q?Stefan_M=C3=A4tje?=
 <stefan.maetje@esd.eu>, socketcan@esd.eu,
 Manivannan Sadhasivam <mani@kernel.org>,
 Thomas Kopp <thomas.kopp@microchip.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>, Jimmy Assarsson
 <extja@kvaser.com>, Axel Forsman <axfo@kvaser.com>
References: <20251029231620.1135640-1-vadim.fedorenko@linux.dev>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20251029231620.1135640-1-vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vadim,

On 30/10/2025 at 00:16, Vadim Fedorenko wrote:
> The patchset converts generic ioctl implementation into a pair of
> ndo_hwtstamp_get/ndo_hwtstamp_set generic callbacks and replaces
> callbacks in drivers.
Thanks for the series. I wasn't aware of the ndo_hwtstamp_{get,set}()
when I wrote the original series. The code looks nicer like this
without the need to use the copy_{from,to}_user() anymore.

I do not have access to my hardware at the moment, so I can not
test. But the code looks straightforward to me, so:

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>


Yours sincerely,
Vincent Mailhol


