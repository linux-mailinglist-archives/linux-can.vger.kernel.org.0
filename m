Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F583C8B66
	for <lists+linux-can@lfdr.de>; Wed,  2 Oct 2019 16:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfJBOiZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Oct 2019 10:38:25 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:21591 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfJBOiY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Oct 2019 10:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1570027100;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=3a7M0AL/ilM4YcdpTp9+hLdRzEquvJEgZFE5vb8AT/I=;
        b=eETu1N1TUgEdSEAL4lW4iYiyCCKJ8CJxJI2S+sRlnQf8e/Wh9cGO/4/z2VsPe9b11K
        do1wcXOZ6G8FxE8zQGqIm1mk5gv0rHkdP282Q4xVCKauOIrj8kMD6xnMo+54jD8yPD48
        eNZbX9drhKAprr3P5ctPriHgL85F0+wJQr87hJGiYOzBz8JieUrO7nJPcenDUeSJnOP0
        8MMUs79AGkDd2fa3nbRYJNGqRWvyquW2EueVqa+G3iYrtmBEm8WCW5ggcL3XzLKYqhSr
        WfwLORAES7NBREU9QCJ58/SSG6kVeNsYd1rS+sffFrTz0XmayQSQsWjXY4/4nH9E8G+I
        +XaA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qHHVdVqJEoSSLRlxw5dDKA=="
X-RZG-CLASS-ID: mo00
Received: from [10.0.0.122]
        by smtp.strato.de (RZmta 44.28.0 DYNA|AUTH)
        with ESMTPSA id e01e3av92EcIQja
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 2 Oct 2019 16:38:18 +0200 (CEST)
Subject: Re: [PATCH] can: don't use deprecated license identifiers
To:     Marc Kleine-Budde <mkl@pengutronix.de>, yegorslists@googlemail.com,
        linux-can@vger.kernel.org
Cc:     wg@grandegger.com
References: <20190919135304.14757-1-yegorslists@googlemail.com>
 <32fc0212-9d3a-02f5-d80f-bd4a453404fa@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <d818fedb-a36e-4075-543c-2619b464e3f1@hartkopp.net>
Date:   Wed, 2 Oct 2019 16:38:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <32fc0212-9d3a-02f5-d80f-bd4a453404fa@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 10/1/19 10:14 PM, Marc Kleine-Budde wrote:
> On 9/19/19 3:53 PM, yegorslists@googlemail.com wrote:
>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> GPL-2.0 license identifier changed to GPL-2.0-only in SPDX v3.0.
>>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> 
> I've changed "include/uapi/linux/can.h" and added it to the patch:
> 
>> --- a/include/uapi/linux/can.h
>> +++ b/include/uapi/linux/can.h
>> @@ -1,4 +1,4 @@
>> -/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
>> +/* SPDX-License-Identifier: ((GPL-2.0-only WITH Linux-syscall-note) OR BSD-3-Clause) */
>>   /*
>>    * linux/can.h
>>    *
> 
> Oliver, I've added your Acked-by to the patch.

Yes, thanks!

Best,
Oliver
