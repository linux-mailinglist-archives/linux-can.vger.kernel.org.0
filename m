Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B273655E1B9
	for <lists+linux-can@lfdr.de>; Tue, 28 Jun 2022 15:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbiF0WyV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 27 Jun 2022 18:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbiF0WyU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 27 Jun 2022 18:54:20 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2433257
        for <linux-can@vger.kernel.org>; Mon, 27 Jun 2022 15:54:19 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id y18so11193894iof.2
        for <linux-can@vger.kernel.org>; Mon, 27 Jun 2022 15:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cyogCsoy11kmMpciXZ21N3veIA+ouiJO53HdSyXPKqo=;
        b=IzvrakVgQ5Pe6+VmhlCD7JceS4ayPXMrbQsxfGJ67bMrXlfOgxC8PlSEZJveOg/dzw
         mUJqxRQaCL/2y3CiLPtp9FQDWNn/3A5Ln5kUxdk0FKUgGEx5i4OxYhLLaGuQErtuasSA
         5X+hhibkOSuiijfgSiRTnpu3Y6OHl2YJO4Bvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cyogCsoy11kmMpciXZ21N3veIA+ouiJO53HdSyXPKqo=;
        b=c/Hw4bvVmiU0Zai7FBF9bmJCinzKSJC4dOdZGcnfim5o9pZZU/CazsQbYAvWE+m+rD
         JPzqmMBmmr0Jem+WhukdeUndi1M2YdTEV7XSMvQX036F0V3KKGPUm3a1JovhY/qLTThv
         9LX8U4K4t7+MfBcj1tQP4zb/1XcgIe4IlQD7Txw8I2HWiUzf1QrsmCatl+RZ9YxcxPsV
         3AA9+jdpm53HKrQ+JnXZePk0HdOJt0RTb2jrSniDECwmz3FDrc6ABT9D01xNxDUGAdtg
         faUyVdz2cqOJIpklMWTcHTqgpZDwM9D0OnkAToTqmOzl6zViX8ueiwF0QMrsmRNh9bqi
         kPBg==
X-Gm-Message-State: AJIora/47xkYWrUf+N6x4Wmd+X8ISbWxoToJLbuidmVUf8BbIIgZ5stL
        73lBLzFMNhdRQTS1XZfsTSZYvA==
X-Google-Smtp-Source: AGRyM1sk1urSpMzR/rHfszWoj3gyWAacu9mBasm+cc2mgbT7otUdULgWvA/yaPE8ZPNWAFJ4rssVVg==
X-Received: by 2002:a02:8609:0:b0:330:e92c:2cc4 with SMTP id e9-20020a028609000000b00330e92c2cc4mr9024050jai.95.1656370458977;
        Mon, 27 Jun 2022 15:54:18 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b17-20020a92c851000000b002d93dbbee35sm5035081ilq.9.2022.06.27.15.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 15:54:18 -0700 (PDT)
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
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e1c416bc-0239-6070-c516-c98332a6491d@linuxfoundation.org>
Date:   Mon, 27 Jun 2022 16:54:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YrX9SBpxp1E2cOyI@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 6/24/22 12:07 PM, Alan Stern wrote:
> On Fri, Jun 24, 2022 at 10:31:06AM -0600, Shuah Khan wrote:
>> On 6/24/22 8:43 AM, Alan Stern wrote:
>>>> It doesn't sound like a there is a compelling reason other than
>>>> "it would be nice to keep the flag values in numerical order".
>>>>
>>>> I would not recommend this option. I am not seeing any value to adding
>>>> change URB_* to USBIP_FLAGS_* layer without some serious techinical
>>>> concerns.
>>>>
>>>>>
>>>>> Another way is to use 0x0400 for FREE_COHERENT.
>>>>> usbip will not take care of this bit as
>>>>> it would be masked.
>>>>>
>>>>
>>>> I would go with this option adding a clear comment with link to this
>>>> discussion.
>>>>
>>>>> Cc Shuah Khan here since she is the maintainer
>>>>> on usbip.
>>>>>
>>>>
>>>> Thank you adding me to the discussion.
>>>
>>> I can see this causing more problems in the future.  There's no hint in
>>> include/linux/usb.h that any of the values it defines are part of a user
>>> API.  If they are, they should be moved to include/uapi/linux/usb/.
>>>
>>
>> Please elaborate on more problems in the future.
> 
> In the future people will want to make other changes to
> include/linux/usb.h and they will not be aware that those changes will
> adversely affect usbip, because there is no documentation saying that
> the values defined in usb.h are part of a user API.  That will be a
> problem, because those changes may be serious and important ones, not
> just decorative or stylistic as in this case.
> 

How often do these values change based on our past experience with these
fields?

>>> In general, if a user program depends on kernel details that are not
>>> designed to be part of a user API, you should expect that the program
>>> will sometimes break from one kernel version to another.
>>>
>>> Yes, I know Linus insists that kernel changes should not cause
>>> regressions in userspace, but the line has to be drawn somewhere.
>>> Otherwise the kernel could never change at all.
>>>
>>
>> I have had to change the usbip sysfs interface api in the past to
>> address security bugs related to information leaks. I am not saying
>> no. I am asking if there is a good reason to do this. So far I haven't
>> heard one.
> 
> I agree with Hongren that values defined in include/linux/ should not be
> part of a user API.  There are two choices:
> 

I agree with this in general. I don't think this is an explicit decision
to make them part of API. It is a consequence of simply copying the
transfer_flags. I am with you both on not being able to recognize the
impact until as this is rather obscure usage hidden away in the packets.
These defines aren't directly referenced.

> 	Move the definitions into include/uapi/linux/, or
> 

Wouldn't this be easier way to handle the change? With this option
the uapi will be well documented.

> 	Add code to translate the values between the numbers used in
> 	userspace and the numbers used in the kernel.  (This is what
> 	was done for urb->transfer_flags in devio.c:proc_do_submiturb()
> 	near line 1862.)
> 

I looked at the code and looks simple enough. I am okay going this route
if we see issues with the option 1.

thanks,
-- Shuah
