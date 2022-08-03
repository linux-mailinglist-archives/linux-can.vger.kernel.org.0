Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5605894FA
	for <lists+linux-can@lfdr.de>; Thu,  4 Aug 2022 01:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237197AbiHCXoS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Aug 2022 19:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237057AbiHCXoR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Aug 2022 19:44:17 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4635D0E7
        for <linux-can@vger.kernel.org>; Wed,  3 Aug 2022 16:44:16 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id l9so2642260ilq.1
        for <linux-can@vger.kernel.org>; Wed, 03 Aug 2022 16:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uWHGfg7aX7ICMwSXUYVKFKVf5d3ah58UuK5hBA1Tu+E=;
        b=ainz+naQb/cSkkTSbrlJkPnd61yZqk6iGas4K5mEyWSY5EZ/NpO7F2OXFEjwqeRqgE
         KaJXpR+8TV4dJEYWZvu7LR2Wtanl0geTl4Il1cBQX8m8a4G6HM6Jch4PmQI4P3orDNBr
         zZKPBR2QIpIsuyeyXVGBkPDzGQ9plXt8hgT8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uWHGfg7aX7ICMwSXUYVKFKVf5d3ah58UuK5hBA1Tu+E=;
        b=jzBrkA+7OpsscN0DNesPzqpYPiI1c3I9m6IMZB+XcD0x9VVDpq7ZLlN1WpEznnGYV/
         ofIs796odz4ICitGBYkV+BPggHgs/vlNjjG/rXuLCJKRuZsW+UZ4UJRNZwkR6FKXr6LN
         gKUaPwNJpOYG/vpCyhV5nL5i5KO17EffvFJmwPtLoVkTCXYKf21SwmTP5RzoIX/DhDN3
         JqgvwGDTMxxtaiNXSv6exKt0mD4TTCKK4QJwdmpge3xk1XddL3fvmEHPa5dPWFhsXhNi
         A2gxzKLa+78LCLnip/aUfsiMbrMhhtgzRJL8CzQFef39i8w4PxmTDOBbP6UVtEoU9RJu
         R//A==
X-Gm-Message-State: AJIora85zlCvVWJLfmsiJ/w4yg+RA5QgUcy2R1fetN/qm81qtamIlHNw
        iqxJiXWXe3WlrGNvrBLkOTu0FA==
X-Google-Smtp-Source: AGRyM1t+7EEqzHBWaMIBsPUh09XoYMcFkX3khxV375085mRxvhaoFmGi/pmZv/uwZ95u6aJszT2p5A==
X-Received: by 2002:a05:6e02:1d8e:b0:2dd:47eb:cd1e with SMTP id h14-20020a056e021d8e00b002dd47ebcd1emr11334660ila.221.1659570256210;
        Wed, 03 Aug 2022 16:44:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c14-20020a92cf4e000000b002ddd861f578sm7474021ilr.72.2022.08.03.16.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 16:44:15 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Hongren Zenithal Zheng <i@zenithal.me>,
        Rhett Aultman <rhett.aultman@samsara.com>,
        linux-usb@vger.kernel.org, linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 <07e82270-cc75-d346-72cf-0a60ffba06dc@linuxfoundation.org>
 <CAMZ6RqKmxzcCEGFyt3wB6rfHECHhLxb3phcs=FOQZGs_S_cvMA@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2a9c8067-2ba8-644f-9362-9f2079e97e11@linuxfoundation.org>
Date:   Wed, 3 Aug 2022 17:44:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqKmxzcCEGFyt3wB6rfHECHhLxb3phcs=FOQZGs_S_cvMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 8/1/22 12:28 PM, Vincent MAILHOL wrote:
> On Tue. 2 Aug. 2022 at 02:48, Shuah Khan <skhan@linuxfoundation.org> wrote:
>> On 6/30/22 8:10 PM, Shuah Khan wrote:
>>> On 6/27/22 7:35 PM, Alan Stern wrote:
>>>> On Mon, Jun 27, 2022 at 04:54:17PM -0600, Shuah Khan wrote:
>>>>> On 6/24/22 12:07 PM, Alan Stern wrote:
>>>>>> In the future people will want to make other changes to
>>>>>> include/linux/usb.h and they will not be aware that those changes will
>>>>>> adversely affect usbip, because there is no documentation saying that
>>>>>> the values defined in usb.h are part of a user API.  That will be a
>>>>>> problem, because those changes may be serious and important ones, not
>>>>>> just decorative or stylistic as in this case.
>>>>>>
>>>>>
>>>>> How often do these values change based on our past experience with these
>>>>> fields?
>>>>
>>>> I don't know.  You could check the git history to find out for certain.
>>>> My guess would be every eight or ten years.
>>>>
>>>>>> I agree with Hongren that values defined in include/linux/ should not be
>>>>>> part of a user API.  There are two choices:
>>>>>>
>>>>>
>>>>> I agree with this in general. I don't think this is an explicit decision
>>>>> to make them part of API. It is a consequence of simply copying the
>>>>> transfer_flags. I am with you both on not being able to recognize the
>>>>> impact until as this is rather obscure usage hidden away in the packets.
>>>>> These defines aren't directly referenced.
>>>>>
>>>>>>      Move the definitions into include/uapi/linux/, or
>>>>>>
>>>>>
>>>>> Wouldn't this be easier way to handle the change? With this option
>>>>> the uapi will be well documented.
>>>>>
>>>>>>      Add code to translate the values between the numbers used in
>>>>>>      userspace and the numbers used in the kernel.  (This is what
>>>>>>      was done for urb->transfer_flags in devio.c:proc_do_submiturb()
>>>>>>      near line 1862.)
>>>>>>
>>>>>
>>>>> I looked at the code and looks simple enough. I am okay going this route
>>>>> if we see issues with the option 1.
>>>>
>>>> It's up to you; either approach is okay with me.  However, I do think
>>>> that the second option is a little better; I don't see any good reason
>>>> why the kernel should be forced to use the same numeric values for these
>>>> flags forever.  Especially since the only user program that needs to
>>>> know them is usbip, which is fairly closely tied to the kernel; if there
>>>> were more programs using those values then they would constitute a good
>>>> reason for choosing the first option.
>>>>
>>>
>>> Thank you Alan and Hongren for your help with this problem. Since there
>>> are no changes to the flags for the time being, I am comfortable going
>>> with the second option.
>>>
>>> I will send a patch soon.
>>>
>>
>> Patch is almost ready to be sent out. Changes aren't bad at all. Hoping to
>> get this done sooner - summer vacations didn't cooperate.
>>
>> Just an update that I haven't forgotten and it will taken care of.
>> thanks,
> 
> Thanks for keeping this under your radar. I also have on my TODO list
> to send a new version of my patch to add the `URB_FREE_COHERENT' flag
> but this time adding an `allocated_length' field to struct urb. I will
> wait for your patch to go first. By the way, I will be out for summer
> holiday for the next couple of weeks so I wasn't planning to submit
> anything soon regardless.
> 

Sounds good. I now have the patch ready to be sent out. I will wait for
the merge window to close before I send it out.

thanks,
-- Shuah
