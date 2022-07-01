Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1B75628C0
	for <lists+linux-can@lfdr.de>; Fri,  1 Jul 2022 04:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiGACKk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 30 Jun 2022 22:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiGACKj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 30 Jun 2022 22:10:39 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264402AE15
        for <linux-can@vger.kernel.org>; Thu, 30 Jun 2022 19:10:38 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id y2so953854ior.12
        for <linux-can@vger.kernel.org>; Thu, 30 Jun 2022 19:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pM1LJjz3F7ELbdHDt8KtX/lLKyDCScxtrvAssHhdOK4=;
        b=GooL1WUSXC4oA5UUX5odF9nGq1dRFh8RpvybGkeK4s02yh4xtL2dd7oi3ltqBAyFyG
         4BTAxCcUvccxjMoqs+qKmuMVsYGcs55cZwGbT44OLqTEyMXFPDNh5Rsca9U/ncmNck9K
         UqfycmSrfL8eD449jRoIvt9N9NBjg78Jlwjpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pM1LJjz3F7ELbdHDt8KtX/lLKyDCScxtrvAssHhdOK4=;
        b=ruYWYnfBR0l9ATpg2sAQR52ZrmPnWTsJeeMyDWNnVWujNQXGATXOypiQIoxV69Dn4g
         W/HR4tLA61VBg23ipyFt4d7cg2K73KDM7IMj9GVQcM4xpPsFZ1YGFYGR1iO0OxxYsWvq
         Fvr9vC4gtJoBN96G6QhOYFVCXrAFgNlCt/BM8F+tkBSLViq5xGtqNrUUlBLXWvE0Tgqg
         zOOyZkKqQG4fe9ZPV6yOm9j/SWyGjF4fjnFZHd9k9M/7XbXUZcogopI2Tc9AV/t963sb
         ZGK2JEmO58w9I2Uhw4/huGaEG0XZDpexzlcfdYOQy029VMlHUMpYSvUdmKldAOA+5u1M
         APiA==
X-Gm-Message-State: AJIora8lQqQdBGkPyCW5XGyxxBcaslnSS4HWgrQpFniJ5dLtqn52RWYl
        v4cKccyjI+Dx/7AW7kCKqmgWVA==
X-Google-Smtp-Source: AGRyM1t6tnL5846dN4UzzYZWbX2Ozucz1apMTiG1EayJCgR+5Nm7jkHV5vLdjePKWKLCn4o3vMlYkQ==
X-Received: by 2002:a02:2348:0:b0:331:b83a:f860 with SMTP id u69-20020a022348000000b00331b83af860mr7592526jau.297.1656641437390;
        Thu, 30 Jun 2022 19:10:37 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d8041000000b00674f9fb1531sm9509346ior.30.2022.06.30.19.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 19:10:36 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Hongren Zenithal Zheng <i@zenithal.me>,
        Rhett Aultman <rhett.aultman@samsara.com>,
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
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b18313ab-c408-83dc-ee96-a64a432fbfcb@linuxfoundation.org>
Date:   Thu, 30 Jun 2022 20:10:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <Yrpa1zpwfauSMoTi@rowland.harvard.edu>
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

On 6/27/22 7:35 PM, Alan Stern wrote:
> On Mon, Jun 27, 2022 at 04:54:17PM -0600, Shuah Khan wrote:
>> On 6/24/22 12:07 PM, Alan Stern wrote:
>>> In the future people will want to make other changes to
>>> include/linux/usb.h and they will not be aware that those changes will
>>> adversely affect usbip, because there is no documentation saying that
>>> the values defined in usb.h are part of a user API.  That will be a
>>> problem, because those changes may be serious and important ones, not
>>> just decorative or stylistic as in this case.
>>>
>>
>> How often do these values change based on our past experience with these
>> fields?
> 
> I don't know.  You could check the git history to find out for certain.
> My guess would be every eight or ten years.
> 
>>> I agree with Hongren that values defined in include/linux/ should not be
>>> part of a user API.  There are two choices:
>>>
>>
>> I agree with this in general. I don't think this is an explicit decision
>> to make them part of API. It is a consequence of simply copying the
>> transfer_flags. I am with you both on not being able to recognize the
>> impact until as this is rather obscure usage hidden away in the packets.
>> These defines aren't directly referenced.
>>
>>> 	Move the definitions into include/uapi/linux/, or
>>>
>>
>> Wouldn't this be easier way to handle the change? With this option
>> the uapi will be well documented.
>>
>>> 	Add code to translate the values between the numbers used in
>>> 	userspace and the numbers used in the kernel.  (This is what
>>> 	was done for urb->transfer_flags in devio.c:proc_do_submiturb()
>>> 	near line 1862.)
>>>
>>
>> I looked at the code and looks simple enough. I am okay going this route
>> if we see issues with the option 1.
> 
> It's up to you; either approach is okay with me.  However, I do think
> that the second option is a little better; I don't see any good reason
> why the kernel should be forced to use the same numeric values for these
> flags forever.  Especially since the only user program that needs to
> know them is usbip, which is fairly closely tied to the kernel; if there
> were more programs using those values then they would constitute a good
> reason for choosing the first option.
> 

Thank you Alan and Hongren for your help with this problem. Since there
are no changes to the flags for the time being, I am comfortable going
with the second option.

I will send a patch soon.

thanks,
-- Shuah
