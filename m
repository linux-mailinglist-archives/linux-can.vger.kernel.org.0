Return-Path: <linux-can+bounces-2145-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247659D3F90
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 17:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0E728348B
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 16:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A2513B58A;
	Wed, 20 Nov 2024 15:59:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5172D13B59E;
	Wed, 20 Nov 2024 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118391; cv=none; b=SSycn1Rv+KOMN1nBdWB4BpesVM5dQ693BLtsGwaeupkeCov3tnb7QB7p81fTsiQRsDFOgVUNlfwaEzKAFT3n8H/WsjMqeYaFjem+xz0AC+dSYgVPEOvlKxyRCjcnV10Wrd67IdxLCM0MPyKyCNqfLjmYE/InGTLkprashahZ09c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118391; c=relaxed/simple;
	bh=7/X5Xivc21sxmq/pddnef6GucgqkKACN4Z84sH7HnEw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qZopL0GQleVpbr8dWD9r267HXnIFgN9paf0kLAlWNPRckR1kNCT/EyvzU89bJ938tMm83jsrOu1AtUmTBZkKSnqyuiKMdRMunfF0+4cgWP8APHzZUjm/h8qhSDQzlnAu/i6vTd0BCJHq4kdrlz+JNz7phV3u0Ob5t0qNkqzLGAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id DD979102FAE;
	Wed, 20 Nov 2024 15:59:38 +0000 (UTC)
Message-ID: <f6baf8dd-4652-450e-a08b-157a806d4459@enpas.org>
Date: Thu, 21 Nov 2024 00:59:28 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] can: can327: Clean up payload encoding in
 can327_handle_prompt()
From: Max Staudt <max@enpas.org>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241119003815.767004-1-max@enpas.org>
 <84998b1d-8b3e-4956-b7fd-323e4999dc7c@wanadoo.fr>
 <4621cc30-92d7-4b07-8058-a1d677f28135@enpas.org>
Content-Language: en-US
In-Reply-To: <4621cc30-92d7-4b07-8058-a1d677f28135@enpas.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/24 02:15, Max Staudt wrote:
> A bit off-topic, but since CAN_RAW came up: Why does CAN_RAW even 
> sanitise anything at all, instead of relying on checks on later layers? 
> It seems like quite a few checks are duplicated. And all the while it's 
> possible for userspace to do weird stuff like seemingly enabling CAN FD 
> on the socket via setsockopt() CAN_RAW_FD_FRAMES, but that's only 
> flipping a bit on the CAN_RAW socket, yet changes nothing underneath. It 
> was quite confusing to read. I suppose the explanation is "legacy"?

Answering my own question here:

CAN_RAW_FD_FRAMES modifies what frames are allowed to pass through the 
CAN_RAW socket towards userspace. This way, simple software handling 
only CAN 2.0 frames may assume that reading anything other than CAN_MTU 
bytes from the socket is an error. This keeps the code simple, and old 
programs have to be written this way, because there is no way for them 
to guess what not yet implemented CAN versions will look like.

So, this option makes a lot more sense to me now, sorry for the extra 
noise :)


Max


