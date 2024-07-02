Return-Path: <linux-can+bounces-946-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34029924873
	for <lists+linux-can@lfdr.de>; Tue,  2 Jul 2024 21:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE1A1F22FD2
	for <lists+linux-can@lfdr.de>; Tue,  2 Jul 2024 19:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC5E6E5ED;
	Tue,  2 Jul 2024 19:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hi1UlIsd"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA12312C477
	for <linux-can@vger.kernel.org>; Tue,  2 Jul 2024 19:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719949053; cv=none; b=qO7lAUNZbB+Ik58TsKaJ/kCRckg0dh3KFCYMHhFAUjSODEilVyt0Lj7Xmg4bBMMlc+q+7XyJzh++CHlYPOpQNOdDgytnGZ65/a29eE+Fc4QLibN0MCsZ/AgZ3WbKSl9PjumrGwFvquZ+23gsQF7Rkb1oH40EHXkfj8DL/nxN6/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719949053; c=relaxed/simple;
	bh=aEiRj7X98Nu/XCYXPja+xo56l0sukFOOHyRWwe6EbEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gv8MqvSmsiiBej4Ng8ef6S47JZlZvROU2hXSa8TNTaOVzFXKA6BHB3IYKU9g5Z+vBAvJh0I/86b0W9lqdwoOKiIKetK/Z+TYv1VTIGWvoOzriY5hI3IfT4Wyu8hWfrdU8lcTFBgAgxb4KtfqojPTzG2OcaOQoYdSJlT8zMdkf/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hi1UlIsd; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52cdb9526e2so3440146e87.0
        for <linux-can@vger.kernel.org>; Tue, 02 Jul 2024 12:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719949050; x=1720553850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9n18Frm4cd8QzNZzOFCAyRyMzfM9eug/IyB0POY6aws=;
        b=hi1UlIsdUbi9W4PRyZNyN1Dycese2ZhCo+gayjpZ3Ps+V7QpWb5PfoNjweAyx5qbuN
         Cif+AXd6RmIBf0Z0ody13ht/SWJ8OUHocLKGSrFXVgK6ulFx6cbvBM96nBpnrHnbeqUP
         XH8Gr+zQQoZNvG/xU9iRDBwXWDaQiL12ybWvclSteNO8H5EbnzgiVoh65vCXXFygPJMw
         9hZs2IQwQMUoSqqf6CmuKaCo9XzOWiH577WWsktpzALFh1yQIkWVF/dP/AVCwQIoXmGF
         oMGtWhOUApOv79qoQy2G8mn6kfl6Uy6/Oqsx3Mms6LqeJ6t5CekiIHUpAAXk2zqV1kQe
         XCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719949050; x=1720553850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9n18Frm4cd8QzNZzOFCAyRyMzfM9eug/IyB0POY6aws=;
        b=eMrxwe1aYH1sQQM27nWOfvj7GEqG2E4ugfSbazGmA2p8AUxMn9/sLPZZhMlQ8aDopc
         Ir1tADvXSHR8VETD13c5oyl2A2iHoA03bt7ehPd0aYOwo7NefRD6KO5G8+JWcUEm3frd
         Krt/v0MOoRgl1pY5xG1yrWzZd06e9wgJGggXS/PSBqL7TFPGa5Y5axECRR3ZbI4kGbeN
         qMREBfh1W8xDziQ6Kd7YL64idTlt0fvN+BA+RYhMe3OTdv+xzqqwA45R06wb+N58x42F
         t0rG13mxlCdRPYfJtqLP7Ak5zLtzo5blSjWonEBRgSn1/bxx06HQVEuBfnC5iblJ+r+d
         rPJw==
X-Gm-Message-State: AOJu0YyLlv3KV5QU0GGa8H5B4oXnl5lNCMOIKrS8TNCngrz87OhuTjDb
	tFSzYDWqpuiFeRLZtex9fdUehow4hft6tCtlIwvXnzFKyqYI/GoU
X-Google-Smtp-Source: AGHT+IFlzpuQWjI3lGG6qDcvD0JLzMm1owTMR7JfIU+ibb8ZOeIPYoehJ5enUcmfGgL2gYfEqIzoOQ==
X-Received: by 2002:a19:f806:0:b0:52e:9389:5694 with SMTP id 2adb3069b0e04-52e93895711mr303427e87.34.1719949049745;
        Tue, 02 Jul 2024 12:37:29 -0700 (PDT)
Received: from [192.168.1.94] (78-70-104-208-no600.tbcn.telia.com. [78.70.104.208])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-52e7ab3b3d3sm1899518e87.281.2024.07.02.12.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 12:37:29 -0700 (PDT)
Message-ID: <e0496250-05af-420c-af21-b185067d0011@gmail.com>
Date: Tue, 2 Jul 2024 21:37:29 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can-next v2 00/15] can: kvaser_usb: Add hardware timestamp
 support to all devices
Content-Language: en-US
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
 Jimmy Assarsson <extja@kvaser.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
References: <20240701154936.92633-1-extja@kvaser.com>
 <CAMZ6Rq+s23=UEokgGjOPy7tHg6CsgEuehr_nXC948s2Vt8Hm5A@mail.gmail.com>
From: Jimmy Assarsson <jimmyassarsson@gmail.com>
In-Reply-To: <CAMZ6Rq+s23=UEokgGjOPy7tHg6CsgEuehr_nXC948s2Vt8Hm5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/24 06:52, Vincent MAILHOL wrote:
> On Tue. 2 Jul. 2024 at 00:50, Jimmy Assarsson <extja@kvaser.com> wrote:
>> From: Jimmy Assarsson <jimmyassarsson@gmail.com>
>>
>> This patch series add hardware timestamp support to all devices supported
>> by the kvaser_usb driver.
>>
>> The first patches resolves a known issue; "Hardware timestamps are not set
>> for CAN Tx frames". I can't remember why this wasn't implemented in the
>> first version of the hydra driver.
>>
>> Followed by, hardware timestamp support for leaf and usbcan based devices.
>>
>> The final patches are removing code used for selecting the correct ethtool
>> and netdev ops.
>>
>> Note: This patch series depends on patch
>> "can: kvaser_usb: Explicitly initialize family in leafimx..." [1].
>>
>> [1] https://lore.kernel.org/linux-can/20240628194529.312968-1-extja@kvaser.com
> 
> Thanks for taking care of the TX timestamps!
> 
> I left one nitpick which is notwithstanding. With or without my
> comment addressed and for the full series:
> 
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Again, thanks for reviewing!

Regards,
jimmy

