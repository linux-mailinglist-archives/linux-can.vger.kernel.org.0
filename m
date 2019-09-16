Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 479B1B3F21
	for <lists+linux-can@lfdr.de>; Mon, 16 Sep 2019 18:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbfIPQlJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 16 Sep 2019 12:41:09 -0400
Received: from mail.iot.bzh ([51.75.236.24]:63000 "EHLO mail.iot.bzh"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731796AbfIPQlJ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 16 Sep 2019 12:41:09 -0400
Received: from [10.18.0.57] (laubervilliers-656-1-70-194.w82-127.abo.wanadoo.fr [82.127.244.194])
        by mail.iot.bzh (Postfix) with ESMTPSA id C6A2C40078;
        Mon, 16 Sep 2019 18:41:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iot.bzh; s=20180822;
        t=1568652061; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=Y9a+ToF09e8Qv/aTBqLh83pEmttl7oJbTL0K66oIjaE=;
        b=aYFgVEXN79ap7QJOcH6VBh/X3YP+K8CQ0QTMrX68bBEP54JgBuP4r9XWalihcfvBHvQGbp
        417JdNXg4XAWpOR86weVwkmCa5gHwfKuYxeSrCmrYTC//YFPgGmcOnh8A8iWntTnGup/LH
        rWfiCeuuz22zIZ4Y/zlHvFdJT3jmtfdoHOc0cSxuC8qjlMshvTRYveYKs1iW89oZ8rViV3
        HDvxHfzAU3Sy6YkV9UxHpbscd/EP83coluSWkZQy53YgJUUI0A8pPnQ7KzdWbfiRAvhUMl
        ePlirgkzvcYIbzfwh1w158Sxlemnc8UYkL4mpB5ihopuV1Q/m/2aIAGUdJCaeA==
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
From:   "Romain Forlot [IoT.bzh]" <romain.forlot@iot.bzh>
Subject: J1939 support
Organization: IOTBZH
Message-ID: <e39e2d61-66ad-d3ce-cd1e-5a2245d632a1@iot.bzh>
Date:   Mon, 16 Sep 2019 18:41:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

We followed work within linux-can-next repository and more particularly 
about the j1939 branches.

They have recently been removed from the repository, is it because they 
will be integrated in the mainline kernel ? (Not found ATM in the master 
branch of the stable linux repository)

Else, where could be found the recent progression on this subject ? Thanks

Regards.

-- 
Romain Forlot - Embedded Engineer - IoT.bzh
romain.forlot@iot.bzh - www.iot.bzh - +33675142438

