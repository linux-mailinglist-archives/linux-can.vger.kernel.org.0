Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2AC1FDBEB
	for <lists+linux-can@lfdr.de>; Fri, 15 Nov 2019 12:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfKOLDP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 15 Nov 2019 06:03:15 -0500
Received: from first.geanix.com ([116.203.34.67]:43116 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbfKOLDO (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 15 Nov 2019 06:03:14 -0500
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 1C3FE904F3;
        Fri, 15 Nov 2019 11:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1573815621; bh=ecznMAsIfNRYie1ueCscZ7p6rNU8WWnjv3Wamh51zQ4=;
        h=To:From:Subject:Date;
        b=hsqRyS0fdsV3kjLzPtq4m41ArWgYIOWmgpiDRakmA8+eZ7R4XDxvRuHyw8hrtmamN
         96wuLKomx1OM5zFIh+mPwcy6PAKH8P25V0FUQWdXJQObgCrY/GHE9x4dCaIat67wTe
         Nl2TUEOh5zIBEyBAYvJ9bOvzq9GrEjF7pnMidJZU5qvHbrpQ16ANhaHtq1WwMw9n8+
         giZz/kMJ6uOtiFn0Fwfkfodfj62PHZDMrAe2buzLANd6ZREheK8bT0nSXz1ptT/yeL
         omAwSjPIgof1C3O6bEdf8aJ7a++J8oZ1eaT2N6FoA2OuTIFZNHFA5B8DzxTpyd6/Yi
         mF3YX2hwZtbjw==
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Subject: CAN bitrate and settings readout
Message-ID: <74972b2d-4580-f3da-b01c-c685680a00ec@geanix.com>
Date:   Fri, 15 Nov 2019 12:02:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on b0d531b295e6
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all,

Is it possible to read the current setting of bitrate and listen-only 
for our can interfaces?

It could be nice to see the bitrate and settings when running `ip link`

/Sean
