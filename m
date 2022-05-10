Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C9D5220FE
	for <lists+linux-can@lfdr.de>; Tue, 10 May 2022 18:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbiEJQWl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 10 May 2022 12:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347286AbiEJQWg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 May 2022 12:22:36 -0400
X-Greylist: delayed 355 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 May 2022 09:18:31 PDT
Received: from pmg01-out3.zxcs.nl (pmg01-out3.zxcs.nl [185.220.172.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD872A3BC0
        for <linux-can@vger.kernel.org>; Tue, 10 May 2022 09:18:30 -0700 (PDT)
Received: from pmg01.zxcs.nl (localhost.localdomain [127.0.0.1])
        by pmg01.zxcs.nl (ZXCS) with ESMTP id F3DFC11EED7
        for <linux-can@vger.kernel.org>; Tue, 10 May 2022 18:12:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=brabofox.nl
        ; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:
        Subject:From:To:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=JaBZXfrz9ABnZJTEsb/Ll5SQVV/3hrf+rMl8oplp0pY=; b=H
        t7Jr6B/fJ8CZkwdbHbHu849HCRNImc3P5piE/0TBXrx4ULmFnNbLSkXgVMTYdf8LKsbe2VYKayQMt
        3up1jeKPHCHUZjcQaXJh6avRXzYtxK3fUFTxQJvGsnWq4VLeTCg0e0XAS1hOrvT8aMHMyp9Cb5lIk
        ArL7DAvb/9YrykRDQhhu+F9xBHiQM01SqAX2hMTOi0qVvhDC9UjounmT3/XEnmQY8HJyFfhJ6HF8E
        O+joVgym21T0rD/jGkuAEo5VgBx/dHqwCUE4tH8JDpKPopXnXZskEwVaENGrD+k7SKpK/Jteta3l0
        OLOESm5pHH/pfKZxV/Oj4Cf6yEDNHu2fw==;
To:     linux-can@vger.kernel.org
From:   Marcel Akkermans <akkermans.m@brabofox.nl>
Subject: Can someone point me in the right direction
Message-ID: <d8571fc8-e020-841f-f20b-088c2ad440c3@brabofox.nl>
Date:   Tue, 10 May 2022 18:12:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: nl
X-Forwarded-For: linux-can@vger.kernel.org
X-AuthUser: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello guru's

I have a Raxda rockpi with waveshare 485 can Hat.
there are strange issues with the can-bus.
I need it to get it going (it's an HMI of a machine I am building)

I have posted my test result at Raxda forum

https://forum.radxa.com/t/rockpi-4b-canbus-fault/9784

If you need more info just email my :)

all hardware runs fine on raspberry 3b

thanks,

greeting
Marcel Akkermans

