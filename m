Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC8D4B3572
	for <lists+linux-can@lfdr.de>; Sat, 12 Feb 2022 15:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiBLOSv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 12 Feb 2022 09:18:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiBLOSu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 12 Feb 2022 09:18:50 -0500
X-Greylist: delayed 591 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Feb 2022 06:18:44 PST
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652A4245AF
        for <linux-can@vger.kernel.org>; Sat, 12 Feb 2022 06:18:44 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 46736240101
        for <linux-can@vger.kernel.org>; Sat, 12 Feb 2022 15:08:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1644674931; bh=Q3dZJXi1GM9ArUASm6QEs5f20j9tFqyY6+Us/BftEPA=;
        h=Date:To:From:Subject:From;
        b=i7EFzKb80abLTilUhlP/nZ6TbawOqW8CWJ+XiwEAKCCv/Ry1YiqASQsE76VSWZ+kd
         s5Wz3B4vsrfjD9mUaOvBGmX94KCARA5l26xVy0y/b9j7i5Dla4gqiFn9XskNIohXKg
         mj1dTyFKFLQsnxj7vnA6yfvwU6nlLbQjqRqbC1+kLtHP8Mmiaotn8jytwjNqfb+uhs
         KAZxt9q6Gd7M7Tk9rVscjTHAT2X64X2ioF5wL+i/pXp1Um5cREhYAa9YqjmMMyGwq9
         x9THx7TcUJycqvwC0eASnSdwJcQPZn3Gf8Y78xcGsG9kWzBKlNGx8rRZgFaCJVZiC5
         plcNWj03udLkw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Jwsm25zQfz6tp9
        for <linux-can@vger.kernel.org>; Sat, 12 Feb 2022 15:08:50 +0100 (CET)
Message-ID: <74db45d1-e59a-d4b3-239a-b919b6211ab4@posteo.de>
Date:   Sat, 12 Feb 2022 14:08:50 +0000
MIME-Version: 1.0
Content-Language: en-US
To:     linux-can <linux-can@vger.kernel.org>
From:   Patrick Menschel <menschel.p@posteo.de>
Subject: can-bcm: EINVAL when TX_DELETE a cyclic CAN FD transmit
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

I'd like to report a strange phenomena that I found while testing BCM
with CAN FD related stuff.

When I have set up a CAN FD frame for a cyclic transmit, and then delete
it with a TX_DELETE bcm msg, I run into EINVAL due to the fact that I
did not set the CAN_FD flag in bcm flags. I did set bcm flags to 0 like
I do for classic can frames.

I'm not sure if that EINVAL actually makes sense because afaik that
CAN_FD flag was introduced to switch the size of the following frames,
which are not present with TX_DELETE.

I already fixed that issue in my Python module, so it works for me.

Kind Regards,
Patrick

