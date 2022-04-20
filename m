Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7040B508533
	for <lists+linux-can@lfdr.de>; Wed, 20 Apr 2022 11:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358822AbiDTJvz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 20 Apr 2022 05:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350547AbiDTJvz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 20 Apr 2022 05:51:55 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Apr 2022 02:49:08 PDT
Received: from mx1.llgoewer.de (mx1.llgoewer.de [IPv6:2a01:4f8:1c1c:7d4a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C2637AB0
        for <linux-can@vger.kernel.org>; Wed, 20 Apr 2022 02:49:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; bh=TM/4LZIT7rcDLwu+J4e/rmrXrxxjdN20MyQfCpZfIGk=;
 c=relaxed/relaxed; d=llgoewer.de;
 h=Subject:Subject:Sender:To:To:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@llgoewer.de; s=default; t=1650447242; v=1; x=1650879242;
 b=y/jE6Q8pg3ii30Hf2AwnL3NrM0tXb1XrK+T/do7CVBUYONlsMnQel02COVdksGPcNEnSDEpp
 XEwpffqLXA1oGNeUeIUwp6Xxi5LBAJBnBgrhsgKBTH9DolWweb3HR2qXKj0CwVZfL4YZX6Uk4Rs
 LDEmipH2zrk/smsuqm17Yg3SumwYcxs5KfNgt7lWmfOrqnM46maawaA2Q1gPmeaz/EP5W8Kh9qN
 /Hr2qZTYWrTq7E0y7Lawk/j3eYERk0d8wc8imu5dWP1vcvK+RZLgrdQhAJI/mR+6q8qu6ubMLSE
 8C+o/YBoILlfPa3GE4EyhtB6Ou9uRXuGlVHKeD+1aezpg==
Received: by mx1.llgoewer.de (envelope-sender <maik@llgoewer.de>) with
 ESMTPS id 0b29efe3; Wed, 20 Apr 2022 09:34:02 +0000
Date:   Wed, 20 Apr 2022 09:34:02 +0000
From:   Maik =?utf-8?B?QWxsZ8O2d2Vy?= <maik@llgoewer.de>
To:     linux-can@vger.kernel.org
Subject: Re: can-isotp: TX stmin violations
Message-ID: <20220420093402.mjyz6lkmgavnxmc3@ganymed>
References: <20220103155254.3htprmrdjur3ke3l@ganymed>
 <d54c6374-bdf4-dfe8-9e9c-5547a743afdb@hartkopp.net>
 <27389f5f-1681-7440-15bd-3c67e4e5daa9@posteo.de>
 <c20468e2-0f9f-bcca-da0f-f3f6470d91be@hartkopp.net>
 <6175074d-6562-91c9-3dce-22ca99815910@posteo.de>
 <19adffae-443c-78bc-fb8c-61ec792a7b6d@hartkopp.net>
 <20220114141929.mz34evi65cgurgek@ganymed>
 <20220114143113.zapz2oszjzfq6p7r@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114143113.zapz2oszjzfq6p7r@pengutronix.de>
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi everyone,

so I hoped I would not have to bother anyone with this issue again,
but our customer wants this fixed.

I am wondering whether someone could point me into the right direction?

Regards,
Maik
