Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6427211A693
	for <lists+linux-can@lfdr.de>; Wed, 11 Dec 2019 10:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfLKJPP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Dec 2019 04:15:15 -0500
Received: from first.geanix.com ([116.203.34.67]:46172 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728265AbfLKJPP (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 11 Dec 2019 04:15:15 -0500
Received: from [192.168.100.11] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id BB89E449;
        Wed, 11 Dec 2019 09:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1576055682; bh=hlvg9nzkKBtVGCPyBLHi8sUQLlwEqSyARhD5ReY1bUU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=giQ2x+4tplSPbPqZUdRdKVhvomeaQ+y/DNaV+a6QLr3oLImCbAYa0yM8mlxitAz/J
         jE2k2cwoA672eHkEIf4ZoklAIEqjO3JDtFyFkJAEpeUvKsMk/JlrjrrEVsYeZpr6xQ
         L/uxm2/bnsHhQPg4sPe3FDMyqC46yOelq4fBPg0rs3bvqxjIjjQmsyThlQJGTdyhjF
         OV/vbCDseFuT2BAL+6nWXmSF35zhgchOL3bJv4Ayb+b+9MGIg1gYafJJRKS5Pv5O6M
         PBfvVGYFMSk3Sdr7173VksZRjhIkiDezntUw6+63A2XUr86q8gXuqVN1t0E3+4dngr
         p65yKdh+6lpRA==
Subject: Re: [PATCH v4] can: m_can: remove double clearing of clock stop
 request bit
To:     Marc Kleine-Budde <mkl@pengutronix.de>, sriram.dash@samsung.com,
        pankj.sharma@samsung.com, dmurphy@ti.com, linux-can@vger.kernel.org
Cc:     martin@geanix.com
References: <20191211063227.84259-1-sean@geanix.com>
 <65673d33-0c7d-5402-b6ee-cc622573c80c@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <4f61d319-0e49-4af7-4daa-95be8f531f59@geanix.com>
Date:   Wed, 11 Dec 2019 10:15:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <65673d33-0c7d-5402-b6ee-cc622573c80c@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 8b5b6f358cc9
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 11/12/2019 09.41, Marc Kleine-Budde wrote:
> On 12/11/19 7:32 AM, Sean Nyekjaer wrote:
>> The CSR bit is already cleared when arriving here so remove this section of
>> duplicate code.
>> The registers set in m_can_config_endisable() is set to same exact
>> values as before this patch.
>>
>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>> Acked-by: Sriram Dash <sriram.dash@samsung.com>
>> Acked-by: Dan Murphy <dmurphy@ti.com>
> 
> Nitpick: You should put your S-o-b at the end of the list.
> 

New rule to me :)
Will remember next time

/Sean
