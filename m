Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 423DADC21F
	for <lists+linux-can@lfdr.de>; Fri, 18 Oct 2019 12:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391195AbfJRKHx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Oct 2019 06:07:53 -0400
Received: from mail.iot.bzh ([51.75.236.24]:3612 "EHLO mail.iot.bzh"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731332AbfJRKHx (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 18 Oct 2019 06:07:53 -0400
Received: from [10.18.0.57] (unknown [10.18.0.57])
        by mail.iot.bzh (Postfix) with ESMTPSA id DC8D440099
        for <linux-can@vger.kernel.org>; Fri, 18 Oct 2019 12:07:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iot.bzh; s=20180822;
        t=1571393266; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=10gI+nNus9Pvk2M/3cuayK7Lj+q9ulnQZJqHzo6wN8Y=;
        b=Rq7P6pPHmJOEi8yjZNJlGkDuak0EvQvlDQG6Yvi5ynGP7ok7Jx1+veo25XoSHuopiHRztK
        WpWzfCVKoV+bRb0gPhRQdhRsz3AP8+eoWJ47Gf/qPYb+AMumlkL1nnZyPYulRufs9q7qb6
        D5yc9mGPCsjzWdCmtu3Lo5UBzouVEkGa/EPRLLIcHdLjKGWPY62bEKgjtdSr+WBfDtUXnc
        TXlCJuQWZuSUsgrdqGljdrpxnjrk8lRMu4wR4ZOoISetk0f8b3Z8LHOsTjcqRqvRp1+28h
        bvpfBvF2/MTyw1PgBrUTYhaPY2hNWVLHlpF1Dy2qLp3fvQ2tQNBtLw8G7as5Rg==
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
From:   "Romain Forlot [IoT.bzh]" <romain.forlot@iot.bzh>
Subject: Questions around J1939 backport to old kernel
Organization: IOTBZH
Message-ID: <b2dd08f0-0390-21c8-83c5-c6c361e78d9c@iot.bzh>
Date:   Fri, 18 Oct 2019 12:07:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

I am wondering what the cost is to backport the j1939 module to an old 
version like a v4.14 LTSI version.

And what the impact is of backporting the whole CAN stack on the CAN 
drivers ? Are there any modifications to drivers once the CAN stack is 
updated ?

Thanks.

-- 
Romain Forlot - Embedded Engineer - IoT.bzh
romain.forlot@iot.bzh - www.iot.bzh - +33675142438

