Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 119D91423DB
	for <lists+linux-can@lfdr.de>; Mon, 20 Jan 2020 07:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgATG6Y (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 20 Jan 2020 01:58:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33378 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgATG6X (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 20 Jan 2020 01:58:23 -0500
Received: by mail-wm1-f66.google.com with SMTP id d139so14050594wmd.0
        for <linux-can@vger.kernel.org>; Sun, 19 Jan 2020 22:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tq0V5tIXwzRcfWYhKcB5qQ/3M8Joz6OCv4mxv+mzWHo=;
        b=WBNp+LErSjM7Q9KQxdtY0iQ4xBOtIx6/W/oA8Kjd6MomaaMWBT+M0SwfILqv6ewGKk
         0oxXux0CYW2WMVQ8WHYdrMqTcspA6XNxXdAGicE5sCsq1Wv2kQqUZU7Ayqp+3+X0D+GV
         RrKxCwDUUTTJsiZevdS2zvnepG+NG7z3RfLNPcOZ7Scx8aXNp7QVe5LBPu29/E0jHPjq
         QvO6Cfy205ifpTTQvxCLFKo2IH7HVueTynKazpJHqA+zQDrdRodP2lD5PMi3wXqD4ve/
         G5QC8reCYF1gk/TYoNnsZSUJQayVy22dqlWbSFAZKXPHC4zkzC5AVEj2chDNhPhSZlw/
         xQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tq0V5tIXwzRcfWYhKcB5qQ/3M8Joz6OCv4mxv+mzWHo=;
        b=caEywRxOTOAX+A214bPfugeeFZ/30wuyK3uJbvXbQQ+X53IjwBCvw8NRzgkUsMgOJ9
         QPA0oWcJDNwfap33KOPfS+XJeuu0xCQmpKPjJ7HYYFqedNCoeWiDQLHBKUrOfkwolIbx
         1MevSxpB6BpTYqvI02BYG7NaWm20ur+y5raJazvsYw5r/e9hvhzjC71GdiTPCP5/Xehj
         p8UldOmkf6Ry/t84oD4Fr1Qqublw/iiaNxCioA9pcmyVqzyLEw3zMgs1SUNMHziaqyx8
         2eoJJy5szP3XpQk6TyUQOg8kFQhC7dKJRvRZSL8mSLI+U2kXnG4a4lOA4jBGWXyVdJL0
         OiOw==
X-Gm-Message-State: APjAAAUjokmWK9fMPFhGUjat275CBE9xg+45xZXy8ZpBf809BF1tcycl
        4u178V9H+UZg+f+YmxNFQaMGsh2f
X-Google-Smtp-Source: APXvYqxOyEsze6UlnZooCigQJ6yeTaMBE243yFSdXbmpxEPSpT8sGL+osjlYzqL/Z0g8WcZRoht6sg==
X-Received: by 2002:a1c:61d6:: with SMTP id v205mr17941145wmb.91.1579503501380;
        Sun, 19 Jan 2020 22:58:21 -0800 (PST)
Received: from ?IPv6:2a02:810d:1540:40aa:49c3:559a:4c9:ae11? ([2a02:810d:1540:40aa:49c3:559a:4c9:ae11])
        by smtp.gmail.com with ESMTPSA id n8sm46241258wrx.42.2020.01.19.22.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2020 22:58:20 -0800 (PST)
Subject: Re: VCAN and CAN-FD DLC versus data length
To:     Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
References: <ec6ffa3c-b208-b76a-d1ac-afd2fb1182a7@gmail.com>
 <444ec681-0591-daf2-84ac-feed5c18ecf9@hartkopp.net>
From:   Andre Naujoks <nautsch2@gmail.com>
Message-ID: <d7acf517-d6dc-41d5-b49b-7ecebb10c627@gmail.com>
Date:   Mon, 20 Jan 2020 07:58:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <444ec681-0591-daf2-84ac-feed5c18ecf9@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Am 17.01.20 um 16:06 schrieb Oliver Hartkopp:
> Hi Andre,
> 
> On 17/01/2020 14.26, Andre Naujoks wrote:
> 
>> If I send a CAN-FD frame with a length, which is not directly 
>> representable by the DLC field, the vcan driver conserves this value. 
>> E.g. a Length of 11 is sent and received in userspace, even though 
>> there is no DLC representation for 11.
>>
>> I talked to a colleague about this and we could not think of a case, 
>> in which this behaviour presents a problem. It is just a small 
>> discrepancy from how a real CAN would behave.
> 
> Right.
> 
> Last time when we changed the can-gw we had a discussion about this 
> "sanitizing" of CAN specific data length here:
> 
> https://marc.info/?l=linux-can&m=156537620228658

Thanks for the link!

> 
> 1. When we get a CAN skb from the real CAN interface this is correct (in 
> CAN length)
> 
> 2. When we send stuff to the real CAN interface the value is fixed 
> before writing the content into the CAN controllers registers.
> 
>> cansend from the can-utils package actually makes sure not to use a 
>> data length, which is not directly representable. This is the output 
>> of a candump oagainst a patched version, which does not "fix" the length.
>>
>> $ candump any & ./patched-cansend vcan0 123##011223344556677889900AA
>>    vcan0  123  [11]  11 22 33 44 55 66 77 88 99 00 AA
> 
> Yes. vcan is just forwarding frames without sanitizing. And even the 
> can-gw can be used to (intentionally) create weird values in the length 
> field - but makes sure that the length boundaries of CAN (0 .. 8) and 
> CAN FD (0 .. 64) are met.
> 
> So using the len value e.g. in a for-statement never lets you write 
> outside the CAN(FD) frame data[].
> 
>> Does anyone have a real case, which would warrant a patch to the vcan 
>> driver to change this? Or should the CAN stack even return EINVAL on a 
>> data length, that is not representable?
> 
> As we had that discussion in the URL above and I can't see anything 
> breaking I would tend to leave it as-is.
> 
> When we would sanitize the vcan skb flow we might end up with many 
> skb_copy() cases instead of skb_clone() (permormance!). And as people 
> may create skbs with PF_PACKET we are also not able to fix-up the length 
> until it reaches the driver layer anyway.
> 
> Does that fit for you?

Yes, it makes sense. This was kind of what I was looking for: Somebody 
else, who thinks this is not an issue.

Thanks again for the detailed explanation! I think I will take care of 
the lengths in my application then. Just to have consistent behaviour on 
CAN vs VCAN. In the end it is a cosmetic issue.

Best Regars
   Andre

> 
> Best,
> Oliver

