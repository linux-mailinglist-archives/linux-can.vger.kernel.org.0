Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241E9699AC9
	for <lists+linux-can@lfdr.de>; Thu, 16 Feb 2023 18:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjBPRKM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 16 Feb 2023 12:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBPRKL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Feb 2023 12:10:11 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA5631E0F
        for <linux-can@vger.kernel.org>; Thu, 16 Feb 2023 09:10:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676567405; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=okmfDFnlPr6Gproh1Lp7WrDijZQITG51KCqq3KQ9hutzI9e9EUFbZIZrnN5Fm2Fc9N
    XNhQ62iwkEkk1pHdAW6u7bK5oLvGKX6bWyoSUacmRBYo9w8Oer8y9B1oRQWrNKjosaOV
    7uJDks5rR+frmMbQ9XEfgO9RtCUXj7sgjxWPurMcaUOLgIUL4Oj08yhbL3fWWJRA87dc
    dq/CvGD705hzY7ABUBhZ06Per+1ijS8kQm9+gkOaL7maxrqwbNEl0mc4S1vgWoyedwii
    5L8bL+0qY2niVI9UBq5MEgMc7g5299sA5JawpHZOQiAAJ/4SJv2LLRGySfxaLkfBKgfl
    sXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1676567405;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=HCtW9HGx2Q6YBiyIxMmNj0XRkYtbQpYtYL3jYqp2dRg=;
    b=SW/AcCrdYTE8HNNVFOzl2+AkQbgyJQPRVm0YnB6FFWHJWs5wowC0XHIAuJmnoq26Dy
    21xL1ekiPGLqhrllWEC7VP0H269G8FKeKGj2JhWbuVYfGNIrc2ikMwoucRkPhYDw1q4h
    Spc4Ma0qcQDpDTo0oOt7BQpRZY7nL/i/z+taRmW9crAOEkhY1VJ+83K3VJd4xKAEi80C
    nQYMhR1sSNYyVYRzNwrmZiJroqOc1TojSIHog9zStegniadjMt1ca7H1ZD/hSl37cW/6
    AQmzjVexuZ79nOKJt+N5rIDi/582id5mOh050hDAuG2gLLmk82Ln+4Ug6vEKWRs58F8G
    fs7Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1676567405;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=HCtW9HGx2Q6YBiyIxMmNj0XRkYtbQpYtYL3jYqp2dRg=;
    b=DwBwYKdVNeWUQsJE6lH0EOZORoa+SqfMT0Kirn3Abr7aGrxKxpmMPz2eVQMftc286q
    DHoS76Z6IRGp4Btlll/bQfOWArj/ON1j0tsqdCDRr0w2S9hrcmx6mUrN50GFihl0qizN
    UnjVVwItC8f2sDppy0vdP+1oZGh8BIrvcNlhqjVee+NRERIAcycku3yGY6qjPTH2soDm
    3TKRkAMLriIbxG1vDr5tWF3iNizAuWLtxBgFxcYGbajavgEUxMTAaXNOomIZNZcBDKyj
    VdNO9Ed47bNKvFQIvMoQvHraNBS0kY5aqBs+fw0CwvVimfoAlsEq2P5lTOxgOKi7HF+x
    xBuA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbVLYqA=="
Received: from [IPV6:2a00:6020:4a8e:5000::83c]
    by smtp.strato.de (RZmta 49.3.0 AUTH)
    with ESMTPSA id x84a76z1GHA4RkD
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 16 Feb 2023 18:10:04 +0100 (CET)
Message-ID: <5b5acff7-30ee-433c-ab59-59da4b371a49@hartkopp.net>
Date:   Thu, 16 Feb 2023 18:09:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: xlinix_can: bug when sending two RTR frames
To:     Hartley Sweeten <HartleyS@visionengravers.com>,
        Michal Simek <michal.simek@amd.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
References: <94e3c5bc-6af9-f240-86fa-2b780a58533f@hartkopp.net>
 <a2256c85-4253-dff5-fa8e-00fc02916095@hartkopp.net>
 <ea15524a-1ed9-0dbb-9511-c333a66a2555@amd.com>
 <BY3PR01MB6515CC4390A51A5564C69634D0A09@BY3PR01MB6515.prod.exchangelabs.com>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <BY3PR01MB6515CC4390A51A5564C69634D0A09@BY3PR01MB6515.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Michal,

On 2/16/23 16:34, Hartley Sweeten wrote:
> On Thursday, February 16, 2023 4:19 AM, Michal Simek wrote:
>>> On 2/7/23 21:45, Oliver Hartkopp wrote:
>>> Hi xilinx_can maintainers,
>>>>
>>>> Hartley Sweeten reported a bug when sending RTR frames with the
>>>> xilinx_can driver here:
>>>>
>>>> https://github.com/linux-can/can-utils/issues/405#
>>>>
>>>> The problem: When sending a single RTR frame (e.g. with 'cansend can0
>>>> 001#R') nothing happens.
>>>>
>>>> Only after sending a *second* RTR frame with 'cansend can0 001#R' the
>>>> two (pending) RTR-frames are sent directly after each other.
>>>>
>>>> This faulty behavior of RTR frame sending is independent of the time
>>>> gap between the two cansend attempts.
>>
>> I read that thread and I am missing details about Zynq board.
>> Are you using any custom zynq board or any xilinx standard evaluation board?
> 
> The system is a Trenz TE0720 SoM on a custom carrier board.
> 
> CAN0 is routed to EMIO.
> 	Tx -> pin E16 (LVCMOS33)
> 	Rx -> pin F16 (LVCMOS33)
> 
> The CAN implementation on the carrier board is like on the ZC702 (TXS0104 buffer / TJA1040T transceiver).
> 
>> Can you please c&p dt fragment you use?
> 
> All of the can@e0008000 node information is from what is created automatically by PetaLinux.
> 
> This is the node info from 'dtc -I fs /sys/firmware/devicetree/base'
> 
>                  can@e0008000 {
>                          compatible = "xlnx,zynq-can-1.0";
>                          clocks = <0x01 0x13 0x01 0x24>;
>                          tx-fifo-depth = <0x40>;
>                          clock-names = "can_clk\0pclk";
>                          status = "okay";
>                          interrupt-parent = <0x04>;
>                          interrupts = <0x00 0x1c 0x04>;
>                          phandle = <0x1a>;
>                          reg = <0xe0008000 0x1000>;
>                          rx-fifo-depth = <0x40>;
>                  };
> 
>> You are using 5.4 kernel which is quite old. Can you please switch to the latest upstream or 5.15 xilinx?
> 
> Uh.. Difficult.
> 
> I'm using PetaLinux 2020.2 right now and _finally_ have something working with it after spending the last year trying to figure it out.
> 
> I'm a bit nervous about installing a newer version of Vivado/Vitis/PetaLinux right now. And I don't know how to make PetaLinux 2020.2 use a different kernel version.
> 

Thanks for picking up this topic!

I double-checked the code and commits from either

- 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/drivers/net/can/xilinx_can.c?h=linux-5.15.y

- 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/drivers/net/can/xilinx_can.c?h=linux-5.4.y

- 
https://github.com/Xilinx/linux-xlnx/blob/xlnx_rebase_v5.15_LTS/drivers/net/can/xilinx_can.c

- xilinx_can.c from the latest 6.2-rc8

And the code sections relevant for this bug report (in the tx path) - 
especially xcan_write_frame() 
https://github.com/Xilinx/linux-xlnx/blob/xlnx_rebase_v5.15_LTS/drivers/net/can/xilinx_can.c#L569 
- do not differ.

So the bug should show up with all the Linux versions and you should be 
able to see it whatever setup you have on your desk.

Best regards,
Oliver
