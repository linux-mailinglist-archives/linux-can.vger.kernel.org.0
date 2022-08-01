Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA727586FAD
	for <lists+linux-can@lfdr.de>; Mon,  1 Aug 2022 19:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiHARmN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 1 Aug 2022 13:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiHARmM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 Aug 2022 13:42:12 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8893618B33
        for <linux-can@vger.kernel.org>; Mon,  1 Aug 2022 10:42:11 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10e6bdbe218so14497809fac.10
        for <linux-can@vger.kernel.org>; Mon, 01 Aug 2022 10:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EyD03pfVpeH7iUsN9cfO7bixQfRvh2HMA3MIy+9mnb0=;
        b=EaLDBYXF7PwQExk638enSBzIYCz8w4YKgHmhUFAfi9ydUT1miL2FJI6k/ArR6MYWTB
         jngIFoOEMAqtfGdwHuTP/Qf8bILm+LtLE/HVrwm80VShbHiCMx9M6YeuqPSEao3uw17R
         6lonxzRiNV6/uzlVDe5Jk5YUSZm7zCH8lxBq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EyD03pfVpeH7iUsN9cfO7bixQfRvh2HMA3MIy+9mnb0=;
        b=pQ0vT/v1wSuk63uTux4mQIoDg2/QkB/B69S2XL3hShrFsHIXApYPELdHrYRbrMKWar
         a2TXC+0kMf78fLAg5GaMawqjt1J6B3X1iVwXWhVNXksuWTT6NGnt4OPCHNd4cyipFcA0
         MGb9Z5orXE8PQnJctYBmK/mKFyJQi5egrPIDZES5ZjoS7UL/vvJTpBrRwAwpJs9hEp1s
         +Ye/2XIBrtyCc9vGEqvzzY+VLJ+e30UyTtd84kvU+6LxmfqHHKURMV5ANeiWfbF9/VEO
         Nvii6krS0qwlyXJJymWoePRD+pPJv4R61fgZwVUaVEiPWXZe6cLMMrCQQ38oZG+Dr4cI
         9kJA==
X-Gm-Message-State: AJIora/lrc95y6p+rGInvwy99tFCk+SaKCMrbX7pgrBmlYot1OnUesjd
        8OABffq3tFqz/2LYdhc11/uz8A==
X-Google-Smtp-Source: AGRyM1sISZF/mWnQtd1spLElr1rjiH1whX16vTUR5jYHPvLPwUzLz1srSaeEOE3J8LSR+OxOZyw1FA==
X-Received: by 2002:a05:6870:61ca:b0:10c:1358:4eaf with SMTP id b10-20020a05687061ca00b0010c13584eafmr8025002oah.111.1659375730489;
        Mon, 01 Aug 2022 10:42:10 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id j8-20020a9d7d88000000b0061c3753c30dsm2876274otn.17.2022.08.01.10.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 10:42:09 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
To:     Alan Stern <stern@rowland.harvard.edu>,
        Hongren Zenithal Zheng <i@zenithal.me>
Cc:     Rhett Aultman <rhett.aultman@samsara.com>,
        linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220609204714.2715188-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-2-rhett.aultman@samsara.com> <YrSjRvb8rIIayGlg@Sun>
 <143b863d-c86b-6678-44e6-38799391fa36@linuxfoundation.org>
 <YrXNltWSYbplstPx@rowland.harvard.edu>
 <aaf64d6c-1893-67ed-013e-67d21c8be152@linuxfoundation.org>
 <YrX9SBpxp1E2cOyI@rowland.harvard.edu>
 <e1c416bc-0239-6070-c516-c98332a6491d@linuxfoundation.org>
 <Yrpa1zpwfauSMoTi@rowland.harvard.edu>
 <b18313ab-c408-83dc-ee96-a64a432fbfcb@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <07e82270-cc75-d346-72cf-0a60ffba06dc@linuxfoundation.org>
Date:   Mon, 1 Aug 2022 11:42:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b18313ab-c408-83dc-ee96-a64a432fbfcb@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 6/30/22 8:10 PM, Shuah Khan wrote:
> On 6/27/22 7:35 PM, Alan Stern wrote:
>> On Mon, Jun 27, 2022 at 04:54:17PM -0600, Shuah Khan wrote:
>>> On 6/24/22 12:07 PM, Alan Stern wrote:
>>>> In the future people will want to make other changes to
>>>> include/linux/usb.h and they will not be aware that those changes will
>>>> adversely affect usbip, because there is no documentation saying that
>>>> the values defined in usb.h are part of a user API.  That will be a
>>>> problem, because those changes may be serious and important ones, not
>>>> just decorative or stylistic as in this case.
>>>>
>>>
>>> How often do these values change based on our past experience with these
>>> fields?
>>
>> I don't know.  You could check the git history to find out for certain.
>> My guess would be every eight or ten years.
>>
>>>> I agree with Hongren that values defined in include/linux/ should not be
>>>> part of a user API.  There are two choices:
>>>>
>>>
>>> I agree with this in general. I don't think this is an explicit decision
>>> to make them part of API. It is a consequence of simply copying the
>>> transfer_flags. I am with you both on not being able to recognize the
>>> impact until as this is rather obscure usage hidden away in the packets.
>>> These defines aren't directly referenced.
>>>
>>>>     Move the definitions into include/uapi/linux/, or
>>>>
>>>
>>> Wouldn't this be easier way to handle the change? With this option
>>> the uapi will be well documented.
>>>
>>>>     Add code to translate the values between the numbers used in
>>>>     userspace and the numbers used in the kernel.  (This is what
>>>>     was done for urb->transfer_flags in devio.c:proc_do_submiturb()
>>>>     near line 1862.)
>>>>
>>>
>>> I looked at the code and looks simple enough. I am okay going this route
>>> if we see issues with the option 1.
>>
>> It's up to you; either approach is okay with me.  However, I do think
>> that the second option is a little better; I don't see any good reason
>> why the kernel should be forced to use the same numeric values for these
>> flags forever.  Especially since the only user program that needs to
>> know them is usbip, which is fairly closely tied to the kernel; if there
>> were more programs using those values then they would constitute a good
>> reason for choosing the first option.
>>
> 
> Thank you Alan and Hongren for your help with this problem. Since there
> are no changes to the flags for the time being, I am comfortable going
> with the second option.
> 
> I will send a patch soon.
> 

Patch is almost ready to be sent out. Changes aren't bad at all. Hoping to
get this done sooner - summer vacations didn't cooperate.

Just an update that I haven't forgotten and it will taken care of.
thanks,
-- Shuah

