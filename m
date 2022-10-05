Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C521D5F5197
	for <lists+linux-can@lfdr.de>; Wed,  5 Oct 2022 11:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiJEJLz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Oct 2022 05:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiJEJLj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Oct 2022 05:11:39 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857AF19C3F
        for <linux-can@vger.kernel.org>; Wed,  5 Oct 2022 02:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1664960971;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=xlfH3BZa4HJZ8Msh7t/Nw589utgJHnAdR3gyITpIfNE=;
    b=ib8OpYyEBoC0ORWSY59A7nw1yRHrnR2lTUryTT9iO+at+/XoTiD4G0aJqZ3UO9xNZC
    gAt4jQBvP3/3ReV5kgHCNN0l/R+R3H4KtiCyAcYxry8QtD3CZv13ZPdn/UIN6yLmyuui
    UB0O5ewMkP8+q6Uqe8zhmkw4jXdqpoicI0qz/aQ3+jytO4cRXVQ416MD3VTqQDfRoiWw
    qe+zAVJ8HSV9aymX8A8C1lWo7d8a7N69fr+diuEUY9pJDQwKPxRWECJowifxCWIDj2W4
    yqu5lyaEXIyo97XqeK+jdvFXPXL1q+OfJeBYFKbw8MRqoIKQGlUCmONMjED6MSZmpcVL
    iQEQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr6hfz3Vg=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::923]
    by smtp.strato.de (RZmta 48.1.3 AUTH)
    with ESMTPSA id Y52aa0y9599VF7S
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 5 Oct 2022 11:09:31 +0200 (CEST)
Message-ID: <3a880265-291c-f768-cbb5-85466d488f94@hartkopp.net>
Date:   Wed, 5 Oct 2022 11:09:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC can-next] can: remove obsolete PCH CAN driver
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Jacob Kroon <jacob.kroon@gmail.com>, linux-can@vger.kernel.org,
        Dario Binacchi <dariobin@libero.it>,
        Wolfgang Grandegger <wg@grandegger.com>
References: <20220924174424.86541-1-socketcan@hartkopp.net>
 <f9b37775-edd5-2a5b-18bc-b34bb69b8324@gmail.com>
 <20220926082526.ofoderi7wrpyolff@pengutronix.de>
 <1653bdae-2ed0-7cc4-993e-cae922f1c524@gmail.com>
 <23216e28-49be-6461-9525-1faad3d439a7@hartkopp.net>
 <20221005070618.o3jdakrgzdvhkswh@pengutronix.de>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20221005070618.o3jdakrgzdvhkswh@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 05.10.22 09:06, Marc Kleine-Budde wrote:
> On 04.10.2022 20:44:07, Oliver Hartkopp wrote:
>> Hi Marc,
>>
>> now that net-next is closed for the merge window would you consider this
>> removal for the next can-next phase or is this something that can be still
>> applied after the merge window to 6.1-rc1?
> 
> This will go into net-next once it's open again. Why do you ask?

I just wasn't sure if such simple removals could also be applied in 
early -rc stages. IIRC I've seen such things on the netdev list one or 
two times before.

But there is no pressure on this topic so the coming net-next phase 
would be definitely fine.

Thanks,
Oliver
