Return-Path: <linux-can+bounces-2755-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3622A2C0E6
	for <lists+linux-can@lfdr.de>; Fri,  7 Feb 2025 11:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83F94169286
	for <lists+linux-can@lfdr.de>; Fri,  7 Feb 2025 10:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B381DE4CD;
	Fri,  7 Feb 2025 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="sWs/g/j3"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-13.smtpout.orange.fr [193.252.22.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B992B9B9;
	Fri,  7 Feb 2025 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925441; cv=none; b=vExKIwtR0cBg2iDMz/pUUfEo4aFlizXq+xdJjS+Og6fUK+gayVDRLmnY+VgPpZKKDfjp8ZsIrGCPg1/1lYKk7j1wghyM5MEipyprapgk9tZFwmRu6IOJhZB+svMxA9hYLgMtsPqW3xMPu9J/RQfsiXKXTlwNGWjcMyqYOWLyICI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925441; c=relaxed/simple;
	bh=Jt0A34KrvXqmStpHxIh6Ewip+WXQC0pFRLgR9gqr8ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7i73HVKZ2+G0yLRHymP1fnGyhonlLIcSZQjoPeDMqEaG2QP955WQQdLun+DekmubD3MVUH0gxWFbjQ2ua6emNngu6pdtI90o8Rfh9Y/xl53Vz12ACU628QxN4ncERHukK3lMDO8JHBg8YXFY1JSmKgmHD4/fGzX3IudJU3VrSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=sWs/g/j3; arc=none smtp.client-ip=193.252.22.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id gLwAtmc5u02zQgLwFtk9LW; Fri, 07 Feb 2025 11:50:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1738925430;
	bh=roZ0GWOd4R4f/96A1hV9cEvbIj4CrM28X3bobulD5w8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=sWs/g/j3OaHMeywKl060QCr+PhkyYE7wkz5l+FunINnTV7UpVl5H7mnNIk8i3WtmT
	 WNV80s/Uo/aVnXyg6h/gMtG0+oGsaaOoGQwYbI9FuOOYPodIkFKyawGBPIi/aThwdw
	 Pd0VReVl+fLHwWKEjMkSJVdSzl7lvCbGohz1tgZkhzTGgaMOhJv5Bd1J7a0LpKx8XO
	 MLojXQt6WflYwc2Iu83r6zdehYCd+5fQSNKyyLloUmT5FDo65juy4TFRFL6T49vcm+
	 LxYnLrGmIygsTJ1qdBhXAlQ4Xvkfvwyi1eX040tpKO/spEcMsgXfq1vtLTZXK3i15m
	 QffzmI1WD2qEA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 07 Feb 2025 11:50:30 +0100
X-ME-IP: 124.33.176.97
Message-ID: <61c229a0-ad0f-494e-856a-9b9958f5f697@wanadoo.fr>
Date: Fri, 7 Feb 2025 19:50:17 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] Documentation: Remove repeated word in docs
To: Charles Han <hanchunchao@inspur.com>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-doc@vger.kernel.org, mkl@pengutronix.de,
 manivannan.sadhasivam@linaro.org, thomas.kopp@microchip.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, cem@kernel.org,
 djwong@kernel.org, corbet@lwn.net
References: <20250207073433.23604-1-hanchunchao@inspur.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250207073433.23604-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/02/2025 at 16:34, Charles Han wrote:
> Remove the repeated word "to" docs.
> 
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

Thanks!

Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>


Yours sincerely,
Vincent Mailhol


