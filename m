Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50273B3E73
	for <lists+linux-can@lfdr.de>; Mon, 16 Sep 2019 18:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfIPQKo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 16 Sep 2019 12:10:44 -0400
Received: from mail.iot.bzh ([51.75.236.24]:22043 "EHLO mail.iot.bzh"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfIPQKo (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 16 Sep 2019 12:10:44 -0400
Received: from [10.18.0.57] (laubervilliers-656-1-70-194.w82-127.abo.wanadoo.fr [82.127.244.194])
        by mail.iot.bzh (Postfix) with ESMTPSA id 7653D40078
        for <linux-can@vger.kernel.org>; Mon, 16 Sep 2019 18:10:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iot.bzh; s=20180822;
        t=1568650237; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q8lLWpZ9OERyVKMLO7Kk8qE8Ah9hg+MSz4nEoLlOwKY=;
        b=ct9Myym0tkoDqNF/5gZ5dHmebgSP/BSs/STIEtsKpT4YBEJZnIi5oWiFPZMLHoAxt+P5NN
        sgIsnuEObnlugcgud/qF8ZioNuhQqqYfMGLHEn+/L0+NUe+rPiZK1L1ExuPWlqFuuHLZhA
        3JBEV+H7TYmUB0qDQYxga9cIzT/iLIftTkATjz2YLD8HApuiVIaZgBXIVSS45DMOXRA1RJ
        RLdXSBn46O5dp1y+RBPGKaHKJYb/iolGMuhfOdl3fplOnY8FSDxy5GT5vkuP3WmIhxUdY0
        wz+ULL7n8nmabfPm6Y/81EAZtFNCV2iVMI5L/qeOj6MVSbgveEBLJTqWRZCv5w==
From:   "Romain Forlot [IoT.bzh]" <romain.forlot@iot.bzh>
Subject: Re: Signed signal value in CAN bus
To:     linux-can@vger.kernel.org
References: <2cea4753-c7b6-94a7-360f-30534591fd9f@iot.bzh>
 <20190913091711.GA22960@x1.vandijck-laurijssen.be>
Organization: IOTBZH
Message-ID: <98f94702-87fa-853d-0319-eb3cc3ce9d13@iot.bzh>
Date:   Mon, 16 Sep 2019 18:10:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190913091711.GA22960@x1.vandijck-laurijssen.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thanks Kurt,

We will  figure it out. Probably implementing several common decoding 
method.

On 13/09/2019 11:17, Kurt Van Dijck wrote:
> Hi,
> On vr, 13 sep 2019 10:38:23 +0200, Romain Forlot [IoT.bzh] wrote:
>> Hi everyone,
>>
>> I have a question about signed numbers in CAN, but I try to handle sign of a
>> signal's value whenever it is a signed value.
>>
>> I would like to have something that works in any cases obviously but for
>> what I found, signed value in CAN bus isn't standardized.
>>
>> You can have:
>>
>>   * signal on N-1 bits, with the subtracted bit representing the sign
>>   * either with 1's complement
>>   * or 2's complement.
>>
>> You could have some bitfield not encoded within classics bytes but in 3 or
>> 13 bits by example, so it could complicate the computing of the signed value
>> depending on the chosen method.
> A common method is to define a range, like -1000 to 1000 to be encoded
> into 0..2000 unsigned.
> In this example, you require 11bits.
> The advantages of doing so are:
> 1) it's not so difficult to convert to/from bitfields, i.e.
>     as you found, properly decoding a negative number from an 11bit value
>     is a bit obscure.
> 2) it leaves explicit room for special/fault codes, above the defined range.
>
> Kind regards,
> Kurt
>
-- 
Romain Forlot - Embedded Engineer - IoT.bzh
romain.forlot@iot.bzh  -www.iot.bzh  - +33675142438

