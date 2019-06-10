Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10F983BE09
	for <lists+linux-can@lfdr.de>; Mon, 10 Jun 2019 23:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388311AbfFJVHb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Jun 2019 17:07:31 -0400
Received: from enpas.org ([46.38.239.100]:49908 "EHLO mail.enpas.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388642AbfFJVHb (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 10 Jun 2019 17:07:31 -0400
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Jun 2019 17:07:30 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 992681002CF;
        Mon, 10 Jun 2019 21:07:29 +0000 (UTC)
Subject: Re: SocketCAN driver for ELM327
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
References: <0d6aff76-d2e6-0807-5919-14eb7337f560@enpas.org>
 <9315b538-d274-dc4e-0098-a4a75fd7cfc4@hartkopp.net>
 <8465897b-8fe8-4222-9c78-846d6ab07ce8@enpas.org>
 <7ff37120-8cd0-8ec1-c9da-ce4d4084012c@enpas.org>
 <ee3aff46-74d4-170c-c0b6-22b6f4930511@hartkopp.net>
 <90807e22-4666-fab6-59ba-c17ec1514e5a@hartkopp.net>
 <b8224669-180e-1177-1993-1aba69e64860@enpas.org>
 <ad31dfa0-7f6c-34b8-0dc6-1a7b23807022@hartkopp.net>
 <ae934287-b8a5-b16e-9a95-03abeb62b620@enpas.org>
 <95af30cf-41b9-dc38-2f4b-f6c733c20520@enpas.org>
 <0be61666-2f27-7c33-5bbb-6e02f49fdf07@hartkopp.net>
From:   Max Staudt <max-linux@enpas.org>
Message-ID: <7def75cf-1765-737c-ca71-3386a18e2040@enpas.org>
Date:   Mon, 10 Jun 2019 23:07:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0be61666-2f27-7c33-5bbb-6e02f49fdf07@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thanks Oliver.

Dear [linux-can], I've sent my driver and documentation as an RFC to the list, so you can review it in-tree. It's a useful tool in my hobby project, and I hope it can be useful for someone else as well.


Regards

Max
